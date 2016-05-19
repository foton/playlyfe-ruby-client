require_relative '../../playlyfe_test_class.rb'

module Playlyfe
  class TeamTest < Playlyfe::Test

    def setup
      stub_game_query do
        @game=connection.game
      end
      #we need players for team.owner
      stub_players_query do
        @game.players
      end  

      @exp_team_hash=Playlyfe::Testing::ExpectedResponses.team1_hash
      @team = Playlyfe::V2::Team.new(@exp_team_hash, @game)
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
            return Playlyfe::Testing::ExpectedResponses.full_teams_leaderboard_hash
          when 'leaderboard1'  
            return Playlyfe::Testing::ExpectedResponses.full_players_leaderboard_hash
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
    
  end
end
