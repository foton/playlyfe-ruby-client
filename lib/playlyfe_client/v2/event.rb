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
          @ev_hash=ev_hash
        end    
  
    end  
  end
end  

require_relative "./event/player_event.rb"
require_relative "./event/team_event.rb"
require_relative "./event/process_event.rb"


module PlaylyfeClient
  module V2
    class Event
   
      def self.build(ev_hash, game, team_player_or_process=nil)   
        event= PlaylyfeClient::V2::PlayerEvent::Base.build(ev_hash,game,team_player_or_process)
        event= PlaylyfeClient::V2::TeamEvent::Base.build(ev_hash,game,team_player_or_process) if event.nil?
        event= PlaylyfeClient::V2::ProcessEvent::Base.build(ev_hash,game,team_player_or_process) if event.nil?
        return event #could be nil!
      end    
    end  
  end
end  

