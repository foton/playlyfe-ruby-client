require_relative '../playlyfe_test_class.rb'

module PlaylyfeClient
  module V2

    #I have to verify, that my stubs are in sync with real API responses
    #player 1 must have 
    #   Multitool 1x
    #   Hammer 1x
    #   Screwdriver 1x
    #   plus_points 19
    #   test_points 24

    class StubbedResponsesTest < PlaylyfeClient::Test

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
        stub_player_profile_query(PlaylyfeClient::Testing::ExpectedResponses.full_profile_hash_for_player1) { stubbed_hash=connection.get_full_player_profile_hash("player1") }
        
        verify_hash(real_hash, stubbed_hash, "player1_profile_hash")
      end 

      def test_verify_team1_members_hash_array
        real_hash=connection.get_full_team_members_hash("team_57349f7b7d0ed66b0193101f")
        stubbed_hash={}
        stub_team_members_query(PlaylyfeClient::Testing::ExpectedResponses.full_team1_members_hash) { stubbed_hash=connection.get_full_team_members_hash("team_57349f9b3409e252002cd0e3") }
        
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
        stub_leaderboard_query(PlaylyfeClient::Testing::ExpectedResponses.full_teams_leaderboard_hash) { stubbed_response=connection.get_full_leaderboard_hash("leaderboard_plus_points") }
        
        verify_hash(real_response, stubbed_response, "team_leaderboard")
      end 

      def test_verify_players_leaderboard_hash
        real_response=connection.get_full_leaderboard_hash("leaderboard1")
        stubbed_response={}
        stub_leaderboard_query(PlaylyfeClient::Testing::ExpectedResponses.full_players_leaderboard_hash) { stubbed_response=connection.get_full_leaderboard_hash("leaderboard1") }
        
        verify_hash(real_response, stubbed_response, "players_leaderboard")
      end 

      def test_verify_all_actions_array
        real_response=connection.get_full_all_actions_array
        stubbed_response={}
        stub_all_actions_query { stubbed_response=connection.get_full_all_actions_array}
        
        fix_counts_for_actions(actions_triggered_during_testing,  real_response, stubbed_response)

        verify_array(real_response, stubbed_response, "all_actions_array")
      end 

      def test_verify_metrics_array
        real_response=connection.get_full_metrics_array
        stubbed_response={}
        stub_metrics_query { stubbed_response=connection.get_full_metrics_array}
        
        verify_array(real_response, stubbed_response, "get_full_metric_array")
      end 

      def test_verify_play_action_hash
        player_id="player1"
        
        real_response=connection.post_play_action(action_id, player_id)
        stubbed_response={}
        stub_play_action(action_id, PlaylyfeClient::Testing::ExpectedResponses.full_play_action_hammer_screwdriver_and_plus_point_hash) { stubbed_response=connection.post_play_action(action_id, player_id) }
                
        #i cannot stop PlaylyfeClient counting action plays, and I do not want to change stubbed values each time I run this test, so I fix it here
        fix_counts_for_actions( actions_triggered_during_testing,  real_response["actions"], stubbed_response["actions"])

        #to revert rewards
        connection.post_play_action(revert_action_id, player_id)

        verify_hash(real_response, stubbed_response, "play_action_hash")

      end 

      def test_verify_player2_activity_feed_array
        player_id="player2" #no actions during test is played on player2
        stubbed_start_time=Time.parse("2016-05-01T00:00:00Z")
        stubbed_end_time=Time.parse("2016-05-21T00:00:00Z")

        real_response=connection.get_player_events_array(player_id, stubbed_start_time, stubbed_end_time)
        stubbed_response={}
        stub_player_events(PlaylyfeClient::Testing::ExpectedResponses.full_player2_events_array) { stubbed_response=connection.get_player_events_array(player_id, stubbed_start_time, stubbed_end_time)}
        
        verify_array(real_response, stubbed_response, "get_full_player2_activity_feed_array")
      end  

      def test_verify_play_not_alowed_action_hash
        player_id="player1"
        
        #once_per_day_action should change only "test_points" metric, so we save "before value" and after this test we change it back to it
        original_test_points=(PlaylyfeClient::Testing::ExpectedResponses.full_profile_hash_for_player1["scores"].detect {|sc| sc["metric"]["id"] == "test_points"})["value"]

        e=assert_raises(PlaylyfeClient::ActionRateLimitExceededError) do

          real_response1=connection.post_play_action(once_per_day_action_id, player_id)
          #second call will not be definitelly first at this day
          real_response2=connection.post_play_action(once_per_day_action_id, player_id)
        end
        expected_error=PlaylyfeClient::Testing::ExpectedResponses.full_error_for_playing_action_over_limit
        assert_equal expected_error.name, e.name 
        assert_equal expected_error.message.gsub(/access_token=\w*/,""), e.message.gsub(/access_token=\w*/,"")

        #to revert rewards, which can happen on first action call
        connection.post_play_action(set_test_points_action_id, player_id, {variables: {tst_p: original_test_points.to_i}})
      end 

      def test_verify_creation_of_player
        player_h={id: "newone", alias: "Just born"}
        real_response= connection.post_create_player(player_h) #{"created" => "connection.post_create_player(player_h)" }
        #verify that player was really created
        assert (connection.get_full_players_hash["data"].collect {|pl| pl["id"]}).include?(player_h[:id])
        
        stubbed_response={}

        stub_player_create(PlaylyfeClient::Testing::ExpectedResponses.player_created_hash(player_h)) do
          stubbed_response=connection.post_create_player(player_h)
          stubbed_response["created"]=real_response["created"]
        end  

        verify_hash(real_response, stubbed_response, "creating_player")

        #cleanup
        connection.delete_player(player_h[:id])
      end  

       def test_verify_game_activity_feed_array
        stubbed_start_time=Time.parse("2016-05-01T00:00:00Z")
        stubbed_end_time=Time.parse("2016-05-21T00:00:00Z")

        real_response=connection.get_game_events_array(stubbed_start_time, stubbed_end_time)
        stubbed_response={}
        stub_game_events(PlaylyfeClient::Testing::ExpectedResponses.game_events_array) { stubbed_response=connection.get_game_events_array(stubbed_start_time, stubbed_end_time)}
        
        verify_array(real_response, stubbed_response, "get_game_events_array")
      end 

      def test_verify_team_activity_feed_array
        team_id="team_57349f7b7d0ed66b0193101f" #"Team1 for RUby client"
        stubbed_start_time=Time.parse("2016-05-01T00:00:00Z")
        stubbed_end_time=Time.parse("2016-05-21T00:00:00Z")

        real_response=connection.get_team_events_array(team_id, stubbed_start_time, stubbed_end_time)
        stubbed_response={}
        stub_team_events(PlaylyfeClient::Testing::ExpectedResponses.team_events_array) { stubbed_response=connection.get_team_events_array(team_id, stubbed_start_time, stubbed_end_time)}
        
        verify_array(real_response, stubbed_response, "get_team_activity/events_feed_array")
      end  


      private

        def verify_stubbing(real_hash, stubbed_hash, what)
          verify_hash(real_hash,stubbed_hash, what)
        end  

        def verify_array(real_arr, stubbed_arr, what)
          assert_equal real_arr.size, stubbed_arr.size, "#{what}.size is #{real_arr.size} instead expected/stubbed #{stubbed_arr.size}: #{real_arr}]"
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
              unless ["timestamp"].include?(key) || (key =="id" && what.include?(":events:"))  #new, old are deltas which 
                verify_simple_value(real_hash[key], stubbed_hash[key], "[#{what}][\"#{key}\"]") 
              end  
            end  
          end 
        end  

        def verify_simple_value(real_value, stubbed_value, what)
          assert_equal real_value, stubbed_value, "#{what} is '#{stubbed_value}' but expected is '#{real_value}'"
        end  

        #i cannot stop PlaylyfeClient counting action plays, and I do not want to change stubbed values each time I run this test, so I fix it here
        def fix_counts_for_actions(action_ids, real_action_array, stubbed_action_array)
          action_ids.each do |action_id|
            real_action_hash=real_action_array.detect {|a| a["id"] == action_id}
            stubbed_action_hash=stubbed_action_array.detect {|a| a["id"] == action_id}
            real_action_hash["count"] = stubbed_action_hash["count"]
          end  
        end

        def action_id
          "get_hammer_screwdriver_and_plus_point"
        end

        def once_per_day_action_id
          "only_one_time_per_day_action"
        end

        def set_test_points_action_id
          "set_test_points_to_value"
        end  
          
        def revert_action_id
          "loose_hammer_screwdriver_and_plus_point"
        end  

        def actions_triggered_during_testing
          [action_id, revert_action_id, once_per_day_action_id, set_test_points_action_id]
        end
    end
  end
end      
