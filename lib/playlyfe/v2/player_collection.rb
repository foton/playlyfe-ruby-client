require_relative "./collection.rb"
require_relative "./player.rb"

module Playlyfe
  module V2
    class PlayerCollection < Playlyfe::V2::Collection
      def find(str)
        (@items.select {|pl| pl.alias.include?(str) || pl.id.include?(str)}).first
      end  
      
      private

        def initialize(game)  
          super
          @items=[]
          fill_items(@game.connection.get_player_hash_array)
        end
        
        def fill_items(player_hash_array)  
          player_hash_array.each do |player_hash|
            @items << Playlyfe::V2::Player.new(player_hash, @game)
          end  
        end  

         
    end  
  end
end    
     
 
