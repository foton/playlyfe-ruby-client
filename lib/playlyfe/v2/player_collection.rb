require_relative "./player.rb"

module Playlyfe
  module V2
    class PlayerCollection 
      attr_reader :game

      def self.xxx
        "aaa"
      end
        
      def all
        @players
      end

      def find(str)
        @players.select {|pl| pl.alias.include?(str) || pl.id.include?(str)}
      end  

      def to_a
        @players
      end  
      
      private

        def initialize(game)  
          @game= game
          @players=[]
          fill_players(@game.connection.get_player_hash_array)
        end
        
        def fill_players(player_hash_array)  
          player_hash_array.each do |player_hash|
            @players << Playlyfe::V2::Player.new(player_hash, @game)
          end  
        end  

         
    end  
  end
end    
     
 
