module PlaylyfeClient
  module V2
    module ProcessEvent 
      class Base < PlaylyfeClient::V2::Event
          
        private

        def initialize(ev_hash,game,process_or_player=nil)
          super(ev_hash,game)

        end 

      end
         
      class ProcessCreatedEvent < PlaylyfeClient::V2::ProcessEvent::Base; end
      class RequestToJoinEvent < PlaylyfeClient::V2::ProcessEvent::Base; end
      class JoinAcceptedEvent < PlaylyfeClient::V2::ProcessEvent::Base; def target_key; "player"; end; end
      class JoinRejectedEvent < PlaylyfeClient::V2::ProcessEvent::Base; end
      class InviteSendEvent < PlaylyfeClient::V2::ProcessEvent::Base; def target_key; "invitee"; end; end
      class InviteAcceptedEvent < PlaylyfeClient::V2::ProcessEvent::Base; def target_key; "inviter"; end; end
      class InviteRejectedEvent < PlaylyfeClient::V2::ProcessEvent::Base; def target_key; "inviter"; end; end
      class JoinedEvent < PlaylyfeClient::V2::ProcessEvent::Base; end
      class RolesChangedEvent < PlaylyfeClient::V2::ProcessEvent::Base; def target_key; (event == "role:assign" ? "player" : nil ); end; end
      class RequestForChangeOfRolesEvent < PlaylyfeClient::V2::ProcessEvent::Base; end
      class ChangeOfRolesAcceptedEvent < PlaylyfeClient::V2::ProcessEvent::Base; def target_key; "player"; end; end
      class ChangeOfRolesRejectedEvent < PlaylyfeClient::V2::ProcessEvent::Base; end
      class KickedOutEvent < PlaylyfeClient::V2::ProcessEvent::Base; def target_key; "player"; end; end
      class LeavedEvent < PlaylyfeClient::V2::ProcessEvent::Base; end
      class ProcessDeletedEvent < PlaylyfeClient::V2::ProcessEvent::Base; end
      class ProcessOwnershipTransferredEvent < PlaylyfeClient::V2::ProcessEvent::Base; def target_key; "new_owner"; end; end
      class ProgressEvent < PlaylyfeClient::V2::ProcessEvent::Base; def target_key; "new_owner"; end; end
      class ResolutionEvent < PlaylyfeClient::V2::ProcessEvent::Base; end

      class Base

        def self.build(ev_hash, game, process=nil)      
          case ev_hash["event"] 
            when "create"
              klass= ProcessCreatedEvent
            when  "delete"
              klass= ProcessDeletedEvent
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
              klass= ProcessOwnershipTransferredEvent
            when "progress"
              klass=ProgressEvent
            when "resolution"  
              klass=ResolutionEvent 
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


