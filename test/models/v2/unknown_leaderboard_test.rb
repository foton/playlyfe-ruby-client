require_relative '../../playlyfe_test_class.rb'

module Playlyfe
  class UnknownLeaderboardTest < Playlyfe::Test

    def setup
      super
      stub_game_query { @game=connection.game}
      stub_players_query { @game.players}
      stub_teams_query { @game.teams}
    end  
      
    def test_create_from_teams_lbd_hash
      exp_leaderboard_definition_hash= Playlyfe::Testing::ExpectedResponses.full_leaderboards_array.last #teams LDB 'leaderboard_plus_points'
      assert_equal 'leaderboard_plus_points', exp_leaderboard_definition_hash["id"]

      exp_leaderboard_positions_hash = Playlyfe::Testing::ExpectedResponses.full_teams_leaderboard_hash
      exp_leaderboard_hash=exp_leaderboard_definition_hash.merge(exp_leaderboard_positions_hash)

      leaderboard = Playlyfe::V2::UnknownLeaderboard.create_from(exp_leaderboard_hash, @game)

      assert leaderboard.kind_of?(Playlyfe::V2::TeamsLeaderboard)

      ["id","name","entity_type", "cycles", "metric", "scope"].each do |key|
        real_value=leaderboard.send(key)  
        expected_value=exp_leaderboard_hash[key]
        assert_equal expected_value, real_value, "Leaderboard '#{exp_leaderboard_hash["id"]}' has #{key.upcase} = '#{real_value}' instead expected '#{expected_value}'."
      end
    end  

    def test_create_from_players_lbd_hash
      exp_leaderboard_definition_hash= Playlyfe::Testing::ExpectedResponses.full_leaderboards_array.first #players LDB 'leaderboard1'
      assert_equal 'leaderboard1', exp_leaderboard_definition_hash["id"]

      exp_leaderboard_positions_hash = Playlyfe::Testing::ExpectedResponses.full_players_leaderboard_hash
      exp_leaderboard_hash=exp_leaderboard_definition_hash.merge(exp_leaderboard_positions_hash)

      leaderboard = Playlyfe::V2::UnknownLeaderboard.create_from(exp_leaderboard_hash, @game)

      assert leaderboard.kind_of?(Playlyfe::V2::PlayersLeaderboard)

      ["id","name","entity_type", "cycles", "metric", "scope"].each do |key|
        real_value=leaderboard.send(key)  
        expected_value=exp_leaderboard_hash[key]
        assert_equal expected_value, real_value, "Leaderboard '#{exp_leaderboard_hash["id"]}' has #{key.upcase} = '#{real_value}' instead expected '#{expected_value}'."
      end
    end

  end
end
