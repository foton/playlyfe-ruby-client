
require_relative "../connection.rb"

module Playlyfe
  module V2
    class Connection < Playlyfe::Connection
  
      def game
        Playlyfe::V2::Game.find_by_connection(self)
      end

      def dummy_player_id
        @dummy_player_id||= get_full_players_hash["data"].first["id"]
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

    end  
  end
end
