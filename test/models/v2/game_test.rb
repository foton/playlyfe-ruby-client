require_relative '../../playlyfe_test_class.rb'

module Playlyfe
  module V2
    class GameTest < Playlyfe::Test
      
      def setup
        stub_game_query do
          @game=connection.game
        end
      end    

      def test_setup_correctly_from_connection
        #@game stubbed in setup
        assert_equal expected_game_hash, @game.to_hash
        assert_equal expected_game_hash, @game.game_hash

        assert_equal expected_game_hash["description"], @game.description
        assert_equal expected_game_hash["id"], @game.id
        assert_equal expected_game_hash["type"], @game.type
        assert_equal expected_game_hash["timezone"], @game.timezone
        assert_equal expected_game_hash["created"], @game.created_at.strftime("%FT%T.%3NZ")
      end  

      def test_fill_all_objects
        skip "get all teams and players"
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
        stub_players_query do
          expected_player_hash_array.each do |pl|
            actual_player=@game.players.find(pl["id"])
            refute actual_player.nil?, "Player '#{pl}' was not found in collection #{@game.players}"
            
            assert_equal pl["id"], actual_player.id, "Player '#{pl}' has id = '#{actual_player.id}' instead expected."
            assert_equal pl["alias"], actual_player.alias, "Player '#{pl}' has alias = '#{actual_player.alias}' instead expected."
            assert_equal pl["enabled"], actual_player.enabled, "Player '#{pl}' has enabled = '#{actual_player.enabled}' instead expected."
          end 
        end        
      end  

      def test_get_teams
        stub_teams_query do
          expected_team_hash_array.each do |exp_team|
            actual_team=@game.teams.find(exp_team["id"])
            refute actual_team.nil?, "Team '#{exp_team}' was not found in collection #{@game.teams}"
          end 
        end        
      end  

      def test_get_leaderboards
        skip
      end   

            

      def test_get_available_actions
        skip
      #   stub_available_actions_query do
      #     expected_available_actions_hash_array.each do |pl|
      #       actual_player=@game.players.find(pl["id"])
      #       refute actual_player.nil?, "Player '#{pl}' was not found in collection #{@game.players}"
      #       assert_equal pl["id"], actual_player.id, "Player '#{pl}' has id = '#{actual_player.id}' instead expected."
      #       assert_equal pl["alias"], actual_player.alias, "Player '#{pl}' has id = '#{actual_player.alias}' instead expected."
      #       assert_equal pl["enabled"], actual_player.enabled, "Player '#{pl}' has id = '#{actual_player.enabled}' instead expected."
      #     end 
      #   end        
      end  

    end    
  end
end
