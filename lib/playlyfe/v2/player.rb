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

      def teams
        []
      end
   
      private 
      
        def initialize(player_hash, game)
          super(game)
          @id=player_hash[:id] || player_hash["id"]
          @alias=player_hash[:alias] || player_hash["alias"]
          @enabled=player_hash[:enabled] || player_hash["enabled"] || false
        end  
    end
  end
end  
