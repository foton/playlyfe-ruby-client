require_relative "../team.rb"

module Playlyfe
  module V2
    class Team < Playlyfe::Team
     
      attr_reader :definition, :access, :game_id, :roles, :owner

      def members
        @members ||= fill_members
      end

      def leaderboards
        []
      end
   
      private 
      
        def initialize(team_hash, game)
          super(game)

          @id=team_hash[:id] || team_hash["id"]
          @name=team_hash[:name] || team_hash["name"]
          @access=team_hash[:access] || team_hash["access"]
          @game_id=team_hash[:game_id] || team_hash["game_id"]
          @roles=team_hash[:roles] || team_hash["roles"]
          @definition=team_hash[:definition] || team_hash["definition"]
          
          @created_at=team_hash[:created_at] || team_hash["created_at"] 
          @created_at=(Time.parse(team_hash[:created] || team_hash["created"]) ) if @created_at.nil? && !(team_hash[:created] || team_hash["created"]).nil?

          own=team_hash[:owner] || team_hash["owner"]
          @owner=nil

          unless own.nil? || own.empty?
            @owner=game.players.find(own[:id] || own["id"])
          end  
        end  

        def fill_members
          @members=[]

          game.connection.get_team_members_hash_array(self.id).each do |player_hash|
            player=game.players.find(player_hash["id"])

            #all players should be listed in game, so if nothing is found raise exception
            if player.nil?
              fail Playlyfe::TeamError.new("{\"error\": \"Player not found\", \"error_description\": \"Player '#{player_hash["id"]}' from '#{self.name}'[#{self.id}] team was not found between game.players!\"}")
            end  
            
            @members << player
          end  
          
          @members
        end  
    end
  end
end  
