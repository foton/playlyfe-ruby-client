require_relative "../player.rb"

module Playlyfe
  module V2
    class Player < Playlyfe::Player
     
      attr_reader :enabled ,:alias, :id

      def enabled?
        enabled
      end  

      def play(action)
        false
      end
      
      def scores
        {points: {} ,sets: {}, states: {}, compound: {}}
      end
        
      def badges
        []
      end

      def points
        {}
      end 

      def levels
        []
      end 

      def roles_in_team(team)
        teams.empty? ? [] : (@teams_roles[team.id].nil? ? [] : @teams_roles[team.id])
      end 

      def teams
        @teams||= fill_teams
      end
   
      private 
      
        def initialize(player_hash, game)
          super(game)
          @id=player_hash[:id] || player_hash["id"]
          @alias=player_hash[:alias] || player_hash["alias"]
          @enabled=player_hash[:enabled] || player_hash["enabled"] || false
        end  

        def profile_hash
          @profile_hash||= game.connection.get_full_player_profile_hash(self.id)
        end  

        def fill_teams
          profile_hash
          @teams=[]
          @teams_roles={}
          @profile_hash["teams"].each do |team_hash|
            team=game.teams.find(team_hash["id"])

            #all teams should be listed in game, so if nothing is found raise exception
            if team.nil?
              fail Playlyfe::PlayerError.new("{\"error\": \"Team not found\", \"error_description\": \"Team '#{team_hash["id"]}' from #{self.id} player profile was not found between game.teams!\"}")
            end  
            
            @teams << team
            @teams_roles[team.id]=team_hash["roles"]

          end  
          @teams
        end  
    end
  end
end  
