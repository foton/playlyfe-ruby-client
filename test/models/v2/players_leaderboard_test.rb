require_relative '../../playlyfe_test_class.rb'

module PlaylyfeClient
  class PlayersLeaderboardTest < PlaylyfeClient::Test

    def setup
      super
      stub_game_query { @game=connection.game}
      stub_players_query { @game.players}
      stub_teams_query { @game.teams}
    
      exp_leaderboard_definition_hash= PlaylyfeClient::Testing::ExpectedResponses.full_leaderboards_array.first #players LDB 'leaderboard1'
      assert_equal 'leaderboard1', exp_leaderboard_definition_hash["id"]

      exp_leaderboard_positions_hash = PlaylyfeClient::Testing::ExpectedResponses.full_players_leaderboard_hash

      @exp_leaderboard_positions = extract_positions(exp_leaderboard_positions_hash["data"])
      @exp_leaderboard_hash=exp_leaderboard_definition_hash.merge(exp_leaderboard_positions_hash)
      @leaderboard = PlaylyfeClient::V2::PlayersLeaderboard.new(@exp_leaderboard_hash, @game)
    end  

    def test_build_from_hash
      ["id","name","entity_type", "cycles", "metric", "scope"].each do |key|
        real_value=@leaderboard.send(key)  
        expected_value=@exp_leaderboard_hash[key]
        assert_equal expected_value, real_value, "Leaderboard '#{@exp_leaderboard_hash["id"]}' has #{key.upcase} = '#{real_value}' instead expected '#{expected_value}'."
      end
       
    end  

    def test_get_positions_correctly
      @leaderboard.positions.each_with_index do |real_value, index|
        expected_value=@exp_leaderboard_positions[index]
        #there are no multipositions, so only one item at each positions
        assert_equal expected_value[:entity]["id"], real_value.first[:entity].id, "Leaderboard '#{@exp_leaderboard_hash["id"]}' has at position #{index} value ENTITY #{real_value} instead expected '#{expected_value}'."
        assert_equal expected_value[:score], real_value.first[:score], "Leaderboard '#{@exp_leaderboard_hash["id"]}'  has at position #{index} value SCORE #{real_value} instead expected '#{expected_value}'."
      end 
    end


    def test_get_multipositions_correctly #there can be more entitities with same rank
      exp_leaderboard_definition_hash= PlaylyfeClient::Testing::ExpectedResponses.full_leaderboards_array.first
      exp_leaderboard_positions_hash = {
          "data" =>  [
            {
              "player" =>  {
                "alias" =>  "player1_alias",
                "id" =>  "player1"
              },
              "score" =>  "6",
              "rank" =>  1
            },
            {
              "player" =>  {
                "alias" =>  "player2_alias",
                "id" =>  "player2"
              },
              "score" =>  "6",
              "rank" =>  1
            },
            {
              "player" =>  {
                "alias" =>  "player3_alias",
                "id" =>  "player3"
              },
              "score" =>  "4",
              "rank" =>  3
            }
          ],
          "total" =>  3
        }
      exp_leaderboard_hash=exp_leaderboard_definition_hash.merge(exp_leaderboard_positions_hash)

      positions = PlaylyfeClient::V2::PlayersLeaderboard.new(exp_leaderboard_hash, @game).positions
       
      assert_equal 3, positions.size 
      assert_equal 2, positions[0].size # player1 and player2 
      assert_equal 0, positions[1].size # empty
      assert_equal 1, positions[2].size # player3
    end  
    
    def test_raise_exception_if_player_is_not_in_game_players          
      leaderboard_hash=@exp_leaderboard_hash.dup
      leaderboard_hash["data"].first["player"]["id"] = "player0"
      e=assert_raises(PlaylyfeClient::LeaderboardError) do
        PlaylyfeClient::V2::PlayersLeaderboard.new(leaderboard_hash, @game)
      end
      assert_equal "Player not found", e.name
      assert_equal "Player 'player0' from 'Leaderboard Test points Name'[leaderboard1] leaderboard was not found between game.players!", e.message
    end 

    private

      def extract_positions(data)
        positions=[]
        data.each do |pos|
          rank=(pos[:rank] || pos["rank"]).to_i - 1
          score=pos[:score] || pos["score"] || 0
          entity= pos[:player] || pos["player"] || pos[:team] || pos["team"] || nil
           
          positions[rank] = {entity: entity, score: score}
        end  
        positions
      end
 

  end
end
