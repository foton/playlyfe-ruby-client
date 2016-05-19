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
        @scores||=fill_scores
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

      def teams_leaderboards
        game.leaderboards.for_teams
      end  

      def players_leaderboards
        game.leaderboards.for_players
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
          teams=[]
          @teams_roles={}
          profile_hash["teams"].each do |team_hash|
            team=game.teams.find(team_hash["id"])

            #all teams should be listed in game, so if nothing is found raise exception
            if team.nil?
              fail Playlyfe::PlayerError.new("{\"error\": \"Team not found\", \"error_description\": \"Team '#{team_hash["id"]}' from #{self.id} player profile was not found between game.teams!\"}")
            end  
            
            teams << team
            @teams_roles[team.id]=team_hash["roles"]

          end  
          teams
        end  

        def fill_scores
          scores={points: {} ,sets: {}, states: {}, compounds: {}}
          profile_hash["scores"].each do |score|
            case score["metric"]["type"]
              when "point"
                scores[:points][score["metric"]["id"].to_sym]=score["value"].to_i
              when "set"
                scores[:sets][score["metric"]["id"].to_sym]=sets_metric_value_from(score["value"])
              when "state"
                scores[:states][score["metric"]["id"].to_sym]=score["value"]["name"] #"value": { "name": "Hell", "description": "The plane of demons" }
              when "compound"
                scores[:compounds][score["metric"]["id"].to_sym]=score["value"].to_i
            end

          end  
          scores
        end  

        def sets_metric_value_from(value)
          (value.each.collect {|item| {name: item["name"], count: item["count"].to_i} } )
        end  
    end
  end
end  
