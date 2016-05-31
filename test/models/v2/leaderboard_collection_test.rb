require_relative '../../playlyfe_test_class.rb'

module PlaylyfeClient
  class LeaderboardCollectionTest < PlaylyfeClient::Test

    def setup
      super
      stub_game_query { @game=connection.game}
      stub_players_query { @game.players}
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

        @collection = PlaylyfeClient::V2::LeaderboardCollection.new(@game)
      end  
    end  

    def test_build_from_game
      assert_equal PlaylyfeClient::Testing::ExpectedResponses.full_leaderboards_array.size, @collection.size
    end  

    def test_can_find_leaderboard_by_id
       PlaylyfeClient::Testing::ExpectedResponses.full_leaderboards_array.each do |exp_leaderboard|
        actual_leaderboard=@collection.find(exp_leaderboard["id"])
        refute actual_leaderboard.nil?, "Leaderboard '#{exp_leaderboard}' was not found in collection #{@collection.to_a} by ID"
      end 
    end

    def test_can_find_leaderboard_by_name
       PlaylyfeClient::Testing::ExpectedResponses.full_leaderboards_array.each do |exp_leaderboard|
        actual_leaderboard=@collection.find(exp_leaderboard["name"])
        refute actual_leaderboard.nil?, "Leaderboard '#{exp_leaderboard}' was not found in collection #{@collection.to_a} by NAME"
      end 
    end
    
    def test_can_convert_to_array  
      assert @collection.to_a.kind_of?(Array)
      assert_equal PlaylyfeClient::Testing::ExpectedResponses.full_leaderboards_array.size, @collection.to_a.size
    end
    
    def test_can_return_all
      assert_equal @collection.to_a , @collection.all
    end  

    def test_can_find_team_only_leaderboards
      exp_ids=(PlaylyfeClient::Testing::ExpectedResponses.full_leaderboards_array.select {|t| t["entity_type"] == "teams"}).collect {|t| t["id"]}
      refute exp_ids.empty?

      assert_equal exp_ids, (@collection.for_teams.collect {|t| t.id}).sort
    end  
   
    def test_can_find_team_only_leaderboards
      exp_ids=(PlaylyfeClient::Testing::ExpectedResponses.full_leaderboards_array.select {|t| t["entity_type"] == "players"}).collect {|t| t["id"]}
      refute exp_ids.empty?

      assert_equal exp_ids, (@collection.for_players.collect {|t| t.id}).sort
    end  

  end
end
