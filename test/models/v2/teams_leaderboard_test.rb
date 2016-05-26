require_relative '../../playlyfe_test_class.rb'

module Playlyfe
  class TeamsLeaderboardTest < Playlyfe::Test

    def setup
      super
      stub_game_query { @game=connection.game}
      stub_players_query { @game.players}
      stub_teams_query { @game.teams}

      exp_leaderboard_definition_hash= Playlyfe::Testing::ExpectedResponses.full_leaderboards_array.last #teams LDB 'leaderboard_plus_points'
      assert_equal 'leaderboard_plus_points', exp_leaderboard_definition_hash["id"]

      exp_leaderboard_positions_hash = Playlyfe::Testing::ExpectedResponses.full_teams_leaderboard_hash

      @exp_leaderboard_positions = extract_positions(exp_leaderboard_positions_hash["data"])
      @exp_leaderboard_hash=exp_leaderboard_definition_hash.merge(exp_leaderboard_positions_hash)
      @leaderboard = Playlyfe::V2::TeamsLeaderboard.new(@exp_leaderboard_hash, @game)
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
        assert_equal expected_value[:entity]["id"], real_value[:entity].id, "Leaderboard '#{@exp_leaderboard_hash["id"]}' has at position #{index} value ENTITY #{real_value} instead expected '#{expected_value}'."
        assert_equal expected_value[:score], real_value[:score], "Leaderboard '#{@exp_leaderboard_hash["id"]}'  has at position #{index} value SCORE #{real_value} instead expected '#{expected_value}'."
      end 
    end
    
    def test_raise_exception_if_player_is_not_in_game_players          
      leaderboard_hash=@exp_leaderboard_hash.dup
      leaderboard_hash["data"].first["team"]["id"] = "team0"
      e=assert_raises(Playlyfe::LeaderboardError) do
        Playlyfe::V2::TeamsLeaderboard.new(leaderboard_hash, @game)
      end
      assert_equal "Team not found", e.name
      assert_equal "Team 'team0' from 'Leaderboard plus points'[leaderboard_plus_points] leaderboard was not found between game.teams!", e.message
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
