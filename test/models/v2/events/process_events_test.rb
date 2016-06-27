require_relative '../../../playlyfe_test_class.rb'

module PlaylyfeClient
  class ProcessEventTest < PlaylyfeClient::Test

      # PlaylyfeClient::V2::ProcessEvent::ProcessCreatedEvent
      # PlaylyfeClient::V2::ProcessEvent::RequestToJoinEvent
      # PlaylyfeClient::V2::ProcessEvent::JoinAcceptedEvent
      # PlaylyfeClient::V2::ProcessEvent::JoinRejectedEvent
      # PlaylyfeClient::V2::ProcessEvent::InviteSendEvent
      # PlaylyfeClient::V2::ProcessEvent::InviteAcceptedEvent
      # PlaylyfeClient::V2::ProcessEvent::InviteRejectedEvent
      # PlaylyfeClient::V2::ProcessEvent::JoinedEvent
      # PlaylyfeClient::V2::ProcessEvent::RolesChangedEvent  #own or other member
      # PlaylyfeClient::V2::ProcessEvent::RequestForChangeOfRolesEvent
      # PlaylyfeClient::V2::ProcessEvent::ChangeOfRolesAcceptedEvent
      # PlaylyfeClient::V2::ProcessEvent::ChangeOfRolesRejectedEvent
      # PlaylyfeClient::V2::ProcessEvent::KickedOutEvent
      # PlaylyfeClient::V2::ProcessEvent::LeavedEvent
      # PlaylyfeClient::V2::ProcessEvent::ProcessDeletedEvent
      # PlaylyfeClient::V2::ProcessEvent::ProcessOwnershipTransferredEvent
      # PlaylyfeClient::V2::ProcessEvent::ProgressEvent
      # PlaylyfeClient::V2::ProcessEvent::ResolutionEvent
      

    [ "process_create",
      "request_to_join",
      "join_accepted",
      "join_rejected",
      "invite_send",
      "invite_accepted",
      "invite_rejected",
      "joined",
      "own_roles_changed",
      "roles_changed_by_assign",
      "request_for_roles_change",
      "request_for_roles_change_accepted",
      "request_for_roles_change_rejected",
      "kicked_out",
      "leaved",
      "process_delete",
      "process_ownership_transfered",
      "progress",
      "resolution"
    ].each do |ev_name|
      define_method("test_can_build_processs_#{ev_name}_event") do
        skip "do not have JSON from Playlyfe for this event. Yet."
      end 
    end  

  end
end    
