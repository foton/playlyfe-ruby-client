require_relative "../team.rb"

module Playlyfe
  module V2
    class Team < Playlyfe::Team
     
      attr_reader :definition, :access, :game_id, :roles, :owner

      def members
        []
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
          @created_at=team_hash[:created_at] || team_hash["created_at"] || (Time.parse(team_hash[:created] || team_hash["created"]) )
          @game_id=team_hash[:game_id] || team_hash["game_id"]
          @roles=team_hash[:roles] || team_hash["roles"]
          @definition=team_hash[:definition] || team_hash["definition"]

          own=team_hash[:owner] || team_hash["owner"]
          @owner=nil

          unless own.nil? || own.empty?
            @owner=game.players.find(own[:id] || own["id"])
          end  
        end  
    end
  end
end  
