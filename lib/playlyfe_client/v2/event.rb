module PlaylyfeClient
  module V2
    class Event
      attr_reader :event, :timestamp, :game
      
      def created_at
        @timestamp
      end  



      private 
          
        def initialize(ev_hash,game)
          @event=ev_hash[:event] || ev_hash["event"]
          ts=ev_hash[:timestamp] || ev_hash["timestamp"]
          @timestamp= (ts.kind_of?(Time) ? ts : Time.parse(ts) )
          @game=game
        end    

    end  
  end
end  

require_relative "./event/player_event.rb"
