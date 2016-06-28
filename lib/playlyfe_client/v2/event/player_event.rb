module PlaylyfeClient
  module V2
    module PlayerEvent 
      class Base < PlaylyfeClient::V2::Event
        attr_reader :actor_id, :actor_alias #who trigger event  (player or admin)
        attr_reader :player_id, :player_alias #who receive results of event (player)
        attr_reader :rule_id , :rule_name,  :process_id, :process_name, :action_id, :action_name #what triggers event
        attr_reader :count #The count with which the action was played.
        attr_reader :changes

        def player
          game.players.find(player_id)
        end  

        def rule
          rule_id #todo
        end

        def process
          process_id #todo
        end  
        
        def action
          return nil if action_id.nil?
          game.actions.find(action_id)
        end    

        private

        def initialize(ev_hash,game,player=nil)
          super(ev_hash,game)

          
          if @ev_hash.has_key?("actor")
            @actor_id=@ev_hash["actor"]["id"]
            @actor_alias=@ev_hash["actor"]["alias"]
          else  
            if player.nil?
              raise "cannot create actor from hash #{@ev_hash} and player #{player}"
            else
              @actor_id=player.id
              @actor_alias=player.alias
            end  
          end  

          ["action", "rule", "process"].each do |att|
            unless @ev_hash[att].nil?  
              instance_variable_set("@#{att}_id", @ev_hash[att]["id"])
              instance_variable_set("@#{att}_name", @ev_hash[att]["name"])
            end
          end  
         

          @count= @ev_hash["count"] || 0

          @player_id=@actor_id
          @player_alias=@actor_alias
          if @ev_hash.has_key?("player")
            @player_id=@ev_hash["player"]["id"]
            @player_alias=@ev_hash["player"]["alias"]
          end  

          set_changes

        end 
 
        def set_changes
          @changes=[]
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

