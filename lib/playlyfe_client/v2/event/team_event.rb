module PlaylyfeClient
  module V2
    module TeamEvent 
      class Base < PlaylyfeClient::V2::Event
        attr_reader :from_player_id, :from_player_alias #who trigger event  (player or admin)
        attr_reader :target_player_id, :target_player_alias #who recieve effects of event
        attr_reader :team_id, :team_name
        attr_reader :roles, :changes
          
        def from_player
          @from_player ||=game.players.find(from_player_id)
        end 
        alias_method :actor, :from_player
        alias_method :actor_id, :from_player_id
        alias_method :actor_alias, :from_player_alias

        def target_player 
          @tagert_player=game.players.find(target_player_id)
        end
        alias_method :inviter, :target_player  
        alias_method :invitee, :target_player  
        alias_method :new_owner, :target_player  
        alias_method :player, :target_player  

        alias_method :inviter_id, :target_player_id  
        alias_method :invitee_id, :target_player_id  
        alias_method :new_owner_id, :target_player_id  
        alias_method :player_id, :target_player_id  

        alias_method :inviter_alias, :target_player_alias  
        alias_method :invitee_alias, :target_player_alias  
        alias_method :new_owner_alias, :target_player_alias  
        alias_method :player_alias, :target_player_alias  

        def team
          @team ||=game.teams.find(team_id)
        end 
       
        private

        def initialize(ev_hash,game,team_or_player=nil)
          super(ev_hash,game)
          
          set_from_player(team_or_player)
          set_target_player(team_or_player)
          set_team(team_or_player)
          set_roles
          set_changes

        end 

        def set_from_player(team_or_player)
          if @ev_hash["actor"].nil?
            if team_or_player.kind_of?(PlaylyfeClient::Player)
              @from_player_id=team_or_player.id
              @from_player_alias=team_or_player.alias
            else
              raise "cannot create actor/from_player from hash #{@ev_hash} and player #{team_or_player}"  
            end
          else    
            @from_player_id=@ev_hash["actor"]["id"]
            @from_player_alias=@ev_hash["actor"]["alias"]
          end  
        end


        def target_key
          nil
        end
          
        def set_target_player(team_or_player)
          return if target_key.nil?
          
          if @ev_hash[target_key].nil?
            if two_player_event?
              if team_or_player.kind_of?(PlaylyfeClient::Player) 
                @target_player_id=team_or_player.id
                @target_player_alias=team_or_player.alias
              else
                raise "cannot create #{target_key} from hash #{@ev_hash} and player #{team_or_player}"  
              end
            end  
          else    
            @target_player_id=@ev_hash[target_key]["id"]
            @target_player_alias=@ev_hash[target_key]["alias"]
          end  
        end

        def set_team(team_or_player)
          if @ev_hash["team"].nil?
            if team_or_player.kind_of?(PlaylyfeClient::Team)
              @team_id=team_or_player.id
              @team_name=team_or_player.alias
            else
              raise "cannot create team from hash #{@ev_hash} and team #{team_or_player}"  
            end
          else    
            @team_id=@ev_hash["team"]["id"]
            @team_name=@ev_hash["team"]["name"]
          end  
        end

        def set_changes
          @changes=[]
          roles=[]
          return @changes if @ev_hash["changes"].nil?

          @ev_hash["changes"].keys.each do |role|
            chng={delta: [ @ev_hash["changes"][role]["old"], @ev_hash["changes"][role]["new"], role ]}
            @changes <<  chng
            roles << role if @ev_hash["changes"][role]["new"] == true
          end  
          @roles = (@roles+roles).uniq
          @changes
        end 


        def set_roles
          @roles=[]
          return @roles if @ev_hash["roles"].nil?

          for k in @ev_hash["roles"].keys
            @roles <<  k if @ev_hash["roles"][k] 
          end  
          @roles
        end  
      end
         
      class TeamCreatedEvent < PlaylyfeClient::V2::TeamEvent::Base; end
      class RequestToJoinEvent < PlaylyfeClient::V2::TeamEvent::Base; end
      class JoinAcceptedEvent < PlaylyfeClient::V2::TeamEvent::Base; def target_key; "player"; end; end
      class JoinRejectedEvent < PlaylyfeClient::V2::TeamEvent::Base; end
      class InviteSendEvent < PlaylyfeClient::V2::TeamEvent::Base; def target_key; "invitee"; end; end
      class InviteAcceptedEvent < PlaylyfeClient::V2::TeamEvent::Base; def target_key; "inviter"; end; end
      class InviteRejectedEvent < PlaylyfeClient::V2::TeamEvent::Base; def target_key; "inviter"; end; end
      class JoinedEvent < PlaylyfeClient::V2::TeamEvent::Base; end
      class RolesChangedEvent < PlaylyfeClient::V2::TeamEvent::Base; def target_key; (event == "role:assign" ? "player" : nil ); end; end
      class RequestForChangeOfRolesEvent < PlaylyfeClient::V2::TeamEvent::Base; end
      class ChangeOfRolesAcceptedEvent < PlaylyfeClient::V2::TeamEvent::Base; def target_key; "player"; end; end
      class ChangeOfRolesRejectedEvent < PlaylyfeClient::V2::TeamEvent::Base; end
      class KickedOutEvent < PlaylyfeClient::V2::TeamEvent::Base; def target_key; "player"; end; end
      class LeavedEvent < PlaylyfeClient::V2::TeamEvent::Base; end
      class TeamDeletedEvent < PlaylyfeClient::V2::TeamEvent::Base; end
      class TeamOwnershipTransferredEvent < PlaylyfeClient::V2::TeamEvent::Base; def target_key; "new_owner"; end; end

      class Base

        def self.build(ev_hash, game, player=nil)      
          case ev_hash["event"] 
            when "create"
              klass= TeamCreatedEvent
            when  "delete"
              klass= TeamDeletedEvent
            when "join"  
              klass= JoinedEvent
            when "join:request"  
              klass= RequestToJoinEvent
            when "leave"
              klass= LeavedEvent
            when "role:change","role:assign"
              klass= RolesChangedEvent
            when "role:request"
              klass= RequestForChangeOfRolesEvent 
            when "join:request:accept"
              klass= JoinAcceptedEvent
            when "role:request:accept"
              klass= ChangeOfRolesAcceptedEvent
            when "join:request:reject"
              klass= JoinRejectedEvent
            when "invite"
              klass= InviteSendEvent
            when "invite:accept"
              klass= InviteAcceptedEvent
            when "invite:reject"
              klass= InviteRejectedEvent
            when "kick"
              klass= KickedOutEvent
            when "transfer"
              klass= TeamOwnershipTransferredEvent
            else  
              return nil  
          end  

          return klass.new(ev_hash, game, player)
        end 

        def two_player_event?
          [JoinAcceptedEvent,ChangeOfRolesAcceptedEvent,InviteSendEvent,InviteAcceptedEvent,InviteRejectedEvent, KickedOutEvent,RolesChangedEvent,TeamOwnershipTransferredEvent].include?(self.class)
        end 

      end    
    end  
  end
end  


