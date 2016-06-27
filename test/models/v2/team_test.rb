require_relative '../../playlyfe_test_class.rb'

module PlaylyfeClient
  class TeamTest < PlaylyfeClient::Test

    def setup
      super
      stub_game_query { @game=connection.game }
      #we need players for team.owner
      stub_players_query { @game.players }
      stub_metrics_query { @game.metrics }
      
      @exp_team_hash=PlaylyfeClient::Testing::ExpectedResponses.team1_hash
      @team = PlaylyfeClient::V2::Team.new(@exp_team_hash, @game)
    end  


    def test_build_from_hash
      ["id","name","access","game_id","definition"].each do |key|
        real_value=@team.send(key)  
        expected_value=@exp_team_hash[key]
        assert_equal expected_value, real_value, "Team '#{@exp_team_hash["id"]}' has #{key.upcase} = '#{real_value}' instead expected '#{expected_value}'."
      end

      real_value=@team.created_at
      expected_value=Time.parse(@exp_team_hash["created"])
      assert_equal expected_value, real_value, "Team '#{@exp_team_hash["id"]}' has CREATED_AT = '#{real_value}' instead expected '#{expected_value}'."

      real_value=@team.owner
      expected_value=@game.players.find(@exp_team_hash["owner"]["id"])
      refute (expected_value.nil?)
      assert_equal expected_value, real_value, "Team '#{@exp_team_hash["id"]}' has OWNER = '#{real_value}' instead expected '#{expected_value}'."


      real_value=@team.roles.sort
      expected_value=@exp_team_hash["roles"].sort
      assert_equal expected_value, real_value, "Team '#{@exp_team_hash["id"]}' has ROLES = '#{real_value}' instead expected '#{expected_value}'."
    end  

    def test_get_template
      assert_equal @team.definition, @team.template
    end
    
    def test_get_members
      stub_team_members_query do
        assert_equal @game.players.find_all(["player1","player2","player3"]), @team.members
      end  
    end

    def test_get_team_leaderboards
      stub_teams_query { @game.teams}
      stub_leaderboards_query do
        
        #stubbing method directly, so it responds with expected responses and do not call real api
        def connection.get_full_leaderboard_hash(leaderboard_id, cycle="alltime", player_id=dummy_player_id) 
          case leaderboard_id 
          when 'leaderboard_plus_points'
            return PlaylyfeClient::Testing::ExpectedResponses.full_teams_leaderboard_hash
          when 'leaderboard1'  
            return PlaylyfeClient::Testing::ExpectedResponses.full_players_leaderboard_hash
          else
            raise "Uncatched stub for leaderboard_id = #{leaderboard_id}"  
          end
        end  

        @game.leaderboards
      end  
      
      real_value= @team.leaderboards
      expected_value=@game.leaderboards.for_teams

      assert_equal expected_value, real_value
    end  

    def test_have_events
      collection=[]
      stub_team_events(PlaylyfeClient::Testing::ExpectedResponses.team_events_array) do 
        collection=@team.events
      end
      
      assert_equal PlaylyfeClient::Testing::ExpectedResponses.team_events_array.size, collection.size
      assert_equal 6, (collection.to_a.select {|e| e.class == PlaylyfeClient::V2::PlayerEvent::LevelChangedEvent}).size
      assert_equal 1, (collection.to_a.select {|e| e.class == PlaylyfeClient::V2::PlayerEvent::AchievementEvent}).size
      assert_equal 2, (collection.to_a.select {|e| e.class == PlaylyfeClient::V2::TeamEvent::InviteAcceptedEvent}).size
      assert_equal 1, (collection.to_a.select {|e| e.class == PlaylyfeClient::V2::TeamEvent::RolesChangedEvent}).size
    end  
    
  end
end
