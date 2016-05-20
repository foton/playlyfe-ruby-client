require_relative '../../playlyfe_test_class.rb'

module Playlyfe
  module V2
    class GameTest < Playlyfe::Test
      
      def setup
        super
        stub_game_query(Playlyfe::Testing::ExpectedResponses.full_game_hash) do
          @game=connection.game
        end
      end    

      def test_setup_correctly_from_connection
        #@game stubbed in setup
        expected_game_hash=Playlyfe::Testing::ExpectedResponses.game_hash

        assert_equal expected_game_hash, @game.to_hash
        assert_equal expected_game_hash, @game.game_hash

        assert_equal expected_game_hash["description"], @game.description
        assert_equal expected_game_hash["id"], @game.id
        assert_equal expected_game_hash["type"], @game.type
        assert_equal expected_game_hash["timezone"], @game.timezone
        assert_equal expected_game_hash["created"], @game.created_at.strftime("%FT%T.%3NZ")
      end  

      # def test_get_game_image
      #   original_image_data=nil
      #   large_image_data=nil
      #   medium_image_data=nil
      #   small_image_data=nil
      #   icon_image_data=nil

      #   #TODO: what and how to test, what wil be usage ? data ur url/path to file  

      #   # assert_equal original_image_data, @game.image_data(:medium)
      #   #assert_equal original_image_data, @game.image_data(:original)
      #   #assert_equal large_image_data, @game.image_data(:large)
      #   #assert_equal medium_image_data, @game.image_data(:medium)
      #   #assert_equal small_image_data, @game.image_data(:small)
      #   #assert_equal icon_image_data, @game.image_data(:icon)
      # end

      def test_get_players
        expected_players_hash_array=Playlyfe::Testing::ExpectedResponses.player_hash_array
        
        stub_players_query do
         expected_players_hash_array.each do |pl|
            actual_player=@game.players.find(pl["id"])
            refute actual_player.nil?, "Player '#{pl}' was not found in collection #{@game.players}"
            
            assert_equal pl["id"], actual_player.id, "Player '#{pl}' has id = '#{actual_player.id}' instead expected."
            assert_equal pl["alias"], actual_player.alias, "Player '#{pl}' has alias = '#{actual_player.alias}' instead expected."
            assert_equal pl["enabled"], actual_player.enabled, "Player '#{pl}' has enabled = '#{actual_player.enabled}' instead expected."
          end 
        end        
      end  

      def test_get_teams
        expected_team_hash_array=Playlyfe::Testing::ExpectedResponses.team_hash_array
        stub_players_query { @game.players } #to load all players

        stub_teams_query do
          assert_equal expected_team_hash_array.size, @game.teams.size

          expected_team_hash_array.each do |exp_team|
            actual_team=@game.teams.find(exp_team["id"])
            refute actual_team.nil?, "Team '#{exp_team}' was not found in collection #{@game.teams}"
          end 
        end        
      end  

      def test_get_leaderboards
        full_leaderboards_array=Playlyfe::Testing::ExpectedResponses.full_leaderboards_array

        stub_players_query { @game.players } #to load all players
        stub_teams_query { @game.teams } #to load all teams
 
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

        stub_leaderboards_query do
          assert_equal full_leaderboards_array.size, @game.leaderboards.size

          full_leaderboards_array.each do |exp_ldb|
            actual_leaderboard=@game.leaderboards.find(exp_ldb["id"])
            refute actual_leaderboard.nil?, "Leaderboard '#{exp_ldb}' was not found in collection #{@game.leaderboards}"
          end 
        end
      end   

      def test_get_available_actions
        expected_available_actions_hash_array=Playlyfe::Testing::ExpectedResponses.full_all_actions_array
        stub_metrics_query do
          stub_all_actions_query do

            assert_equal expected_available_actions_hash_array.size, @game.actions.size

            expected_available_actions_hash_array.each do |exp_action|
              actual_action=@game.available_actions.find(exp_action["id"])
              refute actual_action.nil?, "Action '#{exp_action}' was not found in collection #{@game.available_actions}"
            end 
          end        
        end  
      end  

      def test_get_all_metrics
        expected_metric_array=Playlyfe::Testing::ExpectedResponses.full_metrics_array

        stub_metrics_query do
          assert_equal expected_metric_array.size, @game.metrics.size
          expected_metric_array.each do |exp_metric|
            actual_metric=@game.metrics.find(exp_metric["id"])
            refute actual_metric.nil?, "Metric '#{exp_metric}' was not found in collection #{@game.metrics}"
          end 
        end        
      end 

    end    
  end
end
