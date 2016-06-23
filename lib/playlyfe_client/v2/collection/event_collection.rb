require_relative "../collection.rb"
require_relative "../event.rb"
#require_relative "../event/process/*.rb"
#require_relative "../event/team/*.rb"

module PlaylyfeClient
  module V2
    class EventCollection < PlaylyfeClient::V2::Collection
     
      def find(str)
        e=PlaylyfeClient::CollectionFindOneIsNotSupportedError.new
        e.name="Find item is not supported"
        e.message="This collections has no unique key, so no use for collection.find."
        raise e
      end  
      
      private

        def initialize(game,event_array=[])  
          super(game)
          @items=[]
          event_array= game.connection.get_game_events_array if event_array == []
          fill_items(event_array)
        end
        
        def fill_items(hash_array)  
          hash_array.each do |event_hash|
            @items << get_correct_event_class(event_hash).new(event_hash, @game)
          end  
        end  
         
        def get_correct_event_class(event_hash)
          PlaylyfeClient::V2::Event  #not yet implemented
        end  
         
    end  
  end
end    
     
