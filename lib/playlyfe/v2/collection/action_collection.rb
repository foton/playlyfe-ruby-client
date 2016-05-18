require_relative "../collection.rb"
require_relative "../action.rb"

module Playlyfe
  module V2
    class ActionCollection < Playlyfe::V2::Collection
     
      def find(str)
        (@items.detect {|pl| pl.name == str || pl.id == str})
      end  
      
      private

        def initialize(game)  
          super
          @items=[]
          fill_items(game.connection.get_full_all_actions_array)
        end
        
        def fill_items(hash_array)  
          hash_array.each do |action_hash|
            @items << Playlyfe::V2::Action.new(action_hash, @game)
          end  
        end  

         
    end  
  end
end    
     
