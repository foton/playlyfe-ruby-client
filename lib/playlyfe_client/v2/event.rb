module PlaylyfeClient
  module V2
    class Event
      attr_reader :event, :timestamp, :game 
      
      def created_at
        @timestamp
      end  
  
      def changes
        @changes||=set_changes
      end  


      private 
          
        def initialize(ev_hash,game)
          @event=ev_hash[:event] || ev_hash["event"]
          ts=ev_hash[:timestamp] || ev_hash["timestamp"]
          @timestamp= (ts.kind_of?(Time) ? ts : Time.parse(ts) )
          @game=game
          @ev_hash=ev_hash
        end    

        def set_changes
          @changes=[]
          binding.pry
          return @changes if @ev_hash["changes"].nil?

          for ch in @ev_hash["changes"]
            
            if ch["delta"].has_key?("old")
              chng={delta: [ ch["delta"]["old"], ch["delta"]["new"] ]}
            else
              k=ch["delta"].keys.first
              chng={delta: [ ch["delta"][k]["old"], ch["delta"][k]["new"], k ]}
            end  
            chng[:metric]=game.metrics.find(ch["metric"]["id"])
            
            @changes <<  chng
          end  
        end 

    end  
  end
end  

require_relative "./event/player_event.rb"
require_relative "./event/team_event.rb"
require_relative "./event/process_event.rb"
