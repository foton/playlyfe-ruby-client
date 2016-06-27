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

        def initialize(game, event_array=[], player_team_or_process=nil)  
          @game= game
          @items=[]
          event_array= game.connection.get_game_events_array if event_array == []
          fill_items(event_array,player_team_or_process)
        end
        
        def fill_items(hash_array, player_team_or_process)  
          hash_array.each do |event_hash|
          #  binding.pry
            @items << PlaylyfeClient::V2::Event.build(event_hash, @game, player_team_or_process)
          end  
        end  
        
         
    end  
  end
end    
     
