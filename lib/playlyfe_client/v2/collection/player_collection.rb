require_relative "../collection.rb"
require_relative "../player.rb"

module PlaylyfeClient
  module V2
    class PlayerCollection < PlaylyfeClient::V2::Collection
      def find(str)
        (@items.detect {|pl| pl.alias.include?(str) || pl.id.include?(str)})
      end  
      
      private

        def initialize(game)  
          super
          @items=[]
          fill_items(@game.connection.get_player_hash_array)
        end
        
        def fill_items(player_hash_array)  
          player_hash_array.each do |player_hash|
            @items << PlaylyfeClient::V2::Player.new(player_hash, @game)
          end  
        end  

         
    end  
  end
end    
     
 
