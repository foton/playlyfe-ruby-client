require_relative '../playlyfe_test_class.rb'

module Playlyfe
  module V2

    #I have to verify, that my stubs are in sync with real API responses
    class StubbedResponsesTest < Playlyfe::Test

      def test_verify_game_hash
        real_hash=connection.get_full_game_hash
        stubbed_hash={}
        stub_game_query { stubbed_hash=connection.get_full_game_hash }
        
        verify_hash(real_hash, stubbed_hash, "game_hash")
      end  

      def test_verify_players_hash
        real_hash=connection.get_full_players_hash
        stubbed_hash={}
        stub_players_query { stubbed_hash=connection.get_full_players_hash }
        
        verify_hash(real_hash, stubbed_hash, "players_hash")
      end  


      def test_verify_teams_hash
        real_hash=connection.get_full_teams_hash
        stubbed_hash={}
        stub_teams_query { stubbed_hash=connection.get_full_teams_hash }
        
        verify_hash(real_hash, stubbed_hash, "teams_hash")
      end 

      def test_verify_player1_profile_hash
        real_hash=connection.get_full_player_profile_hash("player1")
        stubbed_hash={}
        stub_player_profile_query { stubbed_hash=connection.get_full_player_profile_hash("player1") }
        
        verify_hash(real_hash, stubbed_hash, "player1_profile_hash")
      end 

      def test_verify_team1_members_hash_array
        real_hash=connection.get_full_team_members_hash("team_57349f7b7d0ed66b0193101f")
        stubbed_hash={}
        stub_team_members_query(Playlyfe::Testing::ExpectedResponses.full_team1_members_hash) { stubbed_hash=connection.get_full_team_members_hash("team_57349f9b3409e252002cd0e3") }
        
        verify_hash(real_hash, stubbed_hash, "team1_ruby_members_hash")
      end 

      def test_verify_leaderboards_array
        real_response=connection.get_full_leaderboards_array
        stubbed_response={}
        stub_leaderboards_query { stubbed_response=connection.get_full_leaderboards_array }
        verify_array(real_response, stubbed_response, "leaderboards_array")
      end 

      def test_verify_teams_leaderboard_hash
        real_response=connection.get_full_leaderboard_hash("leaderboard_plus_points")
        stubbed_response={}
        stub_leaderboard_query(Playlyfe::Testing::ExpectedResponses.full_teams_leaderboard_hash) { stubbed_response=connection.get_full_leaderboard_hash("leaderboard_plus_points") }
        verify_hash(real_response, stubbed_response, "team_leaderboard")
      end 

      def test_verify_players_leaderboard_hash
        real_response=connection.get_full_leaderboard_hash("leaderboard1")
        stubbed_response={}
        stub_leaderboard_query(Playlyfe::Testing::ExpectedResponses.full_players_leaderboard_hash) { stubbed_response=connection.get_full_leaderboard_hash("leaderboard1") }
        verify_hash(real_response, stubbed_response, "players_leaderboard")
      end 

      def test_verify_all_actions_array
        real_response=connection.get_full_all_actions_array
        stubbed_response={}
        stub_all_actions_query { stubbed_response=connection.get_full_all_actions_array}
        verify_array(real_response, stubbed_response, "all_actions_array")
      end 

      def test_verify_metrics_array
        real_response=connection.get_full_metrics_array
        stubbed_response={}
        stub_metrics_query { stubbed_response=connection.get_full_metrics_array}
        verify_array(real_response, stubbed_response, "get_full_metric_array")
      end 

      private

        def verify_stubbing(real_hash, stubbed_hash, what)
          verify_hash(real_hash,stubbed_hash, what)
        end  

        def verify_array(real_arr, stubbed_arr, what)
          assert_equal real_arr.size, stubbed_arr.size, "#{what}.size is #{real_arr.size} instead expected #{stubbed_arr.size}: #{real_arr}]"
          real_arr.each_with_index do |ra_item, index|

            if ra_item.kind_of?(Hash)
              #stubbed_item=(stubbed_arr.detect {|i| i["id"] == ra_item["id"]})
              stubbed_item=stubbed_arr[index]
              verify_hash(ra_item, stubbed_item, "#{what}[#{ra_item["id"]}]")
            elsif ra_item.kind_of?(Array)  
              stubbed_item=stubbed_arr[index]
              verify_array(ra_item,stubbed_item, "#{what}[#{ra_item["id"]}]")
            else  
              stubbed_item=stubbed_arr[index]
              verify_simple_value(ra_item, stubbed_item, "#{what}[#{ra_item["id"]}]")
            end 
          end  
        end  

        def verify_hash(real_hash, stubbed_hash, what)
          assert_equal real_hash.keys.sort, stubbed_hash.keys.sort , "[#{what}] Keys are not the same: REAL #{real_hash.keys.sort}    STUBBED #{stubbed_hash.keys.sort}"
        
          real_hash.keys.each do |key|
            real_value=real_hash[key]

            if real_value.kind_of?(Hash)
              verify_hash(real_value, stubbed_hash[key], "#{what}:#{key}")
            elsif real_value.kind_of?(Array)  
              verify_array(real_value,stubbed_hash[key], "#{what}:#{key}")
            else  
              verify_simple_value(real_hash[key], stubbed_hash[key], "[#{what}][\"#{key}\"]")
            end  
          end 
        end  

        def verify_simple_value(real_value, stubbed_value, what)
          assert_equal real_value, stubbed_value, "#{what} is '#{stubbed_value}' but expected is '#{real_value}'"
        end  

    end
  end
end      
