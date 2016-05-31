require_relative "../collection.rb"
require_relative "../team.rb"

module PlaylyfeClient
  module V2
    class TeamCollection < PlaylyfeClient::V2::Collection
     
      def find(str)
        (@items.detect {|pl| pl.name == str || pl.id == str})
      end  
      
      private

        def initialize(game)  
          super
          @items=[]
          fill_items(@game.connection.get_team_hash_array)
        end
        
        def fill_items(hash_array)  
          hash_array.each do |item_hash|
            @items << PlaylyfeClient::V2::Team.new(item_hash, @game)
          end  
        end  

         
    end  
  end
end    
     
 
