
require_relative "../connection.rb"

module Playlyfe
  module V2
    class Connection < Playlyfe::Connection
  
      def game
        @game ||= Playlyfe::V2::Game.find_by_connection(self)
      end

      def reset_game!
        @game=nil
      end  

      #for calls to "runtime" there MUST be a player_id, even for Metrics or Leaderboards. So we pick first one.
      def dummy_player_id
        @dummy_player_id||= get_full_players_hash["data"].first["id"]
      end  

      def dummy_player_id=(id)
        @dummy_player_id= id
      end 
  
      def get_full_game_hash
        self.get('/admin')
      end
        
      def get_game_hash
        get_full_game_hash["game"]  
      end  

      def get_full_players_hash
        get("/admin/players")
      end   

      def get_player_hash_array
        get_full_players_hash["data"]
      end   

      def get_game_image_data(player_id=dummy_player_id)
        get_raw("/runtime/assets/game", {size: style.to_s, player_id: player_id})
      end
        
      def get_full_teams_hash
        get("/admin/teams")
      end  
      
      def get_team_hash_array
        get_full_teams_hash["data"]
      end  

      def get_full_player_profile_hash(player_id)
        get("/admin/players/#{player_id}")
      end  

      def get_full_team_members_hash(team_id)
        get("/admin/teams/#{team_id}/members")
      end  

      def get_team_members_hash_array(team_id)
        get_full_team_members_hash(team_id)["data"]
      end  
      
      def get_full_leaderboards_array(player_id=dummy_player_id)
        get("/runtime/leaderboards", {player_id: player_id})
      end  

      def get_full_leaderboard_hash(leaderboard_id, cycle="alltime", player_id=dummy_player_id)
        get("/runtime/leaderboards/#{leaderboard_id}", {cycle: cycle, player_id: player_id})
      end 

      def get_full_all_actions_array(player_id=dummy_player_id)
        get("/runtime/actions", {player_id: player_id})
      end  

      def post_play_action(action_id, player_id)
        post("/runtime/actions/#{action_id}/play", {player_id: player_id}, {})
      end  

      def get_full_metrics_array(player_id=dummy_player_id)
        get("/runtime/definitions/metrics", {player_id: player_id})
      end  

      def get_full_activity_feed_array(player_id, start_time=nil, end_time=nil)
        start_str=start_time.utc.strftime("%Y-%m-%dT%H:%M:%S.%LZ") if start_time.kind_of?(Time)
        end_str=end_time.utc.strftime("%Y-%m-%dT%H:%M:%S.%LZ") if start_time.kind_of?(Time)

        #/admin/players/player2/activity?start=2016-05-01T00:00:00Z&end=2016-05-21T00:00:00Z
        if start_time
          #get specified period of time
          get("/admin/players/#{player_id}/activity",{"start" => start_str, "end" => end_str})
        else
          #get last 24 hours
          get("/admin/players/#{player_id}/activity")
        end  
      end  


    end  
  end
end
