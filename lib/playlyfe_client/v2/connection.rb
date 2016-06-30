require_relative "../connection.rb"

module PlaylyfeClient
  module V2
    class Connection < PlaylyfeClient::Connection
  
      def game
        @game ||= PlaylyfeClient::V2::Game.find_by_connection(self)
      end

      def reset_game!
        @game=nil
      end  

      def skip_errors_with(skipping_result, &block)
        begin
          yield
        rescue PlaylyfeClient::ApiCallsLimitExceededError => e
          if @skip_api_calls_limit_exceeded_error
            skipping_result
          else
            raise e  
          end  
        end  
      end  

      #for calls to "runtime" there MUST be a player_id, even for Metrics or Leaderboards. So we pick first one.
      def dummy_player_id
        unless defined?(@dummy_player_id)
          fph= get_full_players_hash["data"]
          @dummy_player_id=fph.empty? ? 0 : fph.first["id"]
        end
        @dummy_player_id
      end  

      def dummy_player_id=(id)
        @dummy_player_id= id
      end 
  
      def get_full_game_hash
        skip_errors_with({"name" => "unknown", "game" => {"id" => 0 ,"title" => "no response"}}) { self.get('/admin') }
      end
        
      def get_game_hash
        get_full_game_hash["game"]  
      end  

      def get_full_players_hash
        skip_errors_with({"data" => [], "total" => 0}) { get("/admin/players") }
      end   

      def get_player_hash_array
        get_full_players_hash["data"]
      end   

      def get_game_image_data(player_id=dummy_player_id)
        skip_errors_with(nil) { get_raw("/runtime/assets/game", {size: style.to_s, player_id: player_id}) }
      end
        
      def get_full_teams_hash
        skip_errors_with({"data" => [], "total" => 0}) { get("/admin/teams") }
      end  
      
      def get_team_hash_array
        get_full_teams_hash["data"]
      end  

      def get_full_player_profile_hash(player_id)
        skip_errors_with({"id" => "0", "alias" => "no response", "scores" => [],  "teams" => []}) { get("/admin/players/#{player_id}") }
      end  

      def get_full_team_members_hash(team_id)
        skip_errors_with({"data" => [], "total" => 0}) { get("/admin/teams/#{team_id}/members") }
      end  

      def get_team_members_hash_array(team_id)
        get_full_team_members_hash(team_id)["data"]
      end  
      
      def get_full_leaderboards_array(player_id=dummy_player_id)
        skip_errors_with([]) { get("/runtime/leaderboards", {player_id: player_id}) }
      end  

      def get_full_leaderboard_hash(leaderboard_id, cycle="alltime", player_id=dummy_player_id)
        skip_errors_with({"data" => [], "total" => 0}) { get("/runtime/leaderboards/#{leaderboard_id}", {cycle: cycle, player_id: player_id}) }
      end 

      def get_full_all_actions_array(player_id=dummy_player_id)
        skip_errors_with([]) { get("/runtime/actions", {player_id: player_id}) }
      end  

      def post_play_action(action_id, player_id, body ={})
        skip_errors_with({"actions" => [], "events" => []}) { post("/runtime/actions/#{action_id}/play", {player_id: player_id}, body) }
      end  

      def get_full_metrics_array(player_id=dummy_player_id)
        skip_errors_with([]) { get("/runtime/definitions/metrics", {player_id: player_id}) }
      end  

      def get_player_events_array(player_id, start_time=nil, end_time=nil)
        #/admin/players/player2/activity?start=2016-05-01T00:00:00Z&end=2016-05-21T00:00:00Z
        skip_errors_with([]) do 
          if start_time
            #get specified period of time
            get("/admin/players/#{player_id}/activity",{"start" => start_str(start_time), "end" => end_str(end_time)})
          else
            #get last 24 hours
            get("/admin/players/#{player_id}/activity")
          end  
        end
      end  
   
      def post_create_player(player_h)
        skip_errors_with({"id" => "0", "alias" => "no response", "scores" => [],  "teams" => []}) { post("/admin/players", {}, player_h) }
      end  

      def delete_player(player_id)
        skip_errors_with(nil) { delete("/admin/players/#{player_id}") }
      end

      def get_game_events_array(start_time=nil, end_time=nil)
        skip_errors_with([]) do 
          if start_time
            #get specified period of time
            get("/admin/activity",{"start" => start_str(start_time), "end" => end_str(end_time)})
          else
            #get last 24 hours
            get("/admin/activity")
          end 
        end  
      end  

      def get_team_events_array(team_id, start_time=nil, end_time=nil)
        skip_errors_with([]) do 
          if start_time
            #get specified period of time
            get("/admin/teams/#{team_id}/activity",{"start" => start_str(start_time), "end" => end_str(end_time)})
          else
            #get last 24 hours
            get("/admin/teams/#{team_id}/activity")
          end 
        end  
      end  

      private

        def start_str(start_time)
          start_time.utc.strftime("%Y-%m-%dT%H:%M:%S.%LZ") if start_time.kind_of?(Time)
        end  

        def end_str(end_time)
          end_time.utc.strftime("%Y-%m-%dT%H:%M:%S.%LZ") if end_time.kind_of?(Time)
        end  

    end  
  end
end
