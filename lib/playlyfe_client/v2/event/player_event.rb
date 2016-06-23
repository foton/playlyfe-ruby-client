module PlaylyfeClient
  module V2
    module PlayerEvent 
      class Base < PlaylyfeClient::V2::Event
        attr_reader :actor_id, :actor_alias #who trigger event  (player or admin)
        attr_reader :player_id, :player_alias #who receive results of event (player)
        attr_reader :rule , :process, :action #what triggers event
        attr_reader :count #The count with which the action was played.
        attr_reader :changes



        private

        def initialize(ev_hash,game,player=nil)
          super(ev_hash,game)

          
          if ev_hash.has_key?("actor")
            @actor_id=ev_hash["actor"]["id"]
            @actor_alias=ev_hash["actor"]["alias"]
          else  
            if player.nil?
              raise "cannot create actor from hash #{ev_hash} and player #{player}"
            else
              @actor_id=player.id
              @actor_alias=player.alias
            end  
          end  

          @rule= ev_hash["rule"]["id"] unless ev_hash["rule"].nil?
          @process= ev_hash["process"]["id"] unless ev_hash["process"].nil?
          @action= ev_hash["action"]["id"] unless ev_hash["action"].nil?
          @count= ev_hash["count"] || 0

          @player_id=@actor_id
          @player_alias=@actor_alias
          if ev_hash.has_key?("player")
            @player_id=ev_hash["player"]["id"]
            @player_alias=ev_hash["player"]["alias"]
          end  

          set_changes(ev_hash)

        end 

        def set_changes(ev_hash)
          @changes=[]
          for ch in ev_hash["changes"]
            
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
   
      class LevelChangedEvent < PlaylyfeClient::V2::PlayerEvent::Base; end
      class AchievementEvent < PlaylyfeClient::V2::PlayerEvent::Base; end
      class ActionPlayedEvent < PlaylyfeClient::V2::PlayerEvent::Base; end
      class CustomRuleAppliedEvent < PlaylyfeClient::V2::PlayerEvent::Base; end
      class ScoreUpdatedByAdminEvent < PlaylyfeClient::V2::PlayerEvent::Base; end

      class Base

        def self.build(ev_hash, game, player=nil)      
          case ev_hash["event"] 
            when "level"
              klass= LevelChangedEvent
            when  "action"
              klass= ActionPlayedEvent
            when "achievement"  
              klass= AchievementEvent
            when "custom_rule"  
              klass= CustomRuleAppliedEvent
            when "score"
              klass= ScoreUpdatedByAdminEvent
            else  
              return nil  
          end  

          return klass.new(ev_hash, game, player)
        end  

      end    
    end  
  end
end  

