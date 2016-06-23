require_relative '../../playlyfe_test_class.rb'

module PlaylyfeClient
  module V2
    class EventTest < PlaylyfeClient::Test

      def setup
        @game = "fake_game"
        @event= PlaylyfeClient::V2::Event.new({"timestamp" => "2012-04-11T08:00:00.500Z", "event" => "unknown_event"}, @game)
      end  
     
      def test_have_timestamp
        assert_equal Time.parse("2012-04-11T08:00:00.500Z"), @event.created_at
        assert_equal @event.created_at, @event.timestamp
      end
      
      def test_have_event
        assert_equal "unknown_event", @event.event
      end

    end
  end  
end    

      # PlaylyfeClient::TeamEvent::CreateTeamEvent
      # PlaylyfeClient::TeamEvent::RequestToJoinEvent
      # PlaylyfeClient::TeamEvent::JoinAcceptedEvent
      # PlaylyfeClient::TeamEvent::JoinRejectedEvent
      # PlaylyfeClient::TeamEvent::JoinEvent
      # PlaylyfeClient::TeamEvent::ChangeOfRolesEvent  #own or other member
      # PlaylyfeClient::TeamEvent::RequestForChangeOfRolesEvent
      # PlaylyfeClient::TeamEvent::ChangeOfRolesAcceptedEvent
      # PlaylyfeClient::TeamEvent::ChangeOfRolesRejectedEvent
      # PlaylyfeClient::TeamEvent::KickOutEvent
      # PlaylyfeClient::TeamEvent::LeaveEvent
      # PlaylyfeClient::TeamEvent::DeleteTeamEvent
      # PlaylyfeClient::TeamEvent::TeamOwnershipTransferredEvent
      
      # PlaylyfeClient::ProcessEvent::ProgressEvent
      # PlaylyfeClient::ProcessEvent::ResolutionEvent
      # PlaylyfeClient::ProcessEvent::CreateProcessEvent
      # PlaylyfeClient::ProcessEvent::RequestToJoinEvent
      # PlaylyfeClient::ProcessEvent::JoinAcceptedEvent
      # PlaylyfeClient::ProcessEvent::JoinRejectedEvent
      # PlaylyfeClient::ProcessEvent::JoinEvent
      # PlaylyfeClient::ProcessEvent::ChangeOfRolesEvent  #own or other member
      # PlaylyfeClient::ProcessEvent::RequestForChangeOfRolesEvent
      # PlaylyfeClient::ProcessEvent::ChangeOfRolesAcceptedEvent
      # PlaylyfeClient::ProcessEvent::ChangeOfRolesRejectedEvent
      # PlaylyfeClient::ProcessEvent::KickOutEvent
      # PlaylyfeClient::ProcessEvent::LeaveEvent
      # PlaylyfeClient::ProcessEvent::DeleteProcessEvent
      # PlaylyfeClient::ProcessEvent::ProcessOwnershipTransferredEvent
      
      
      # PlaylyfeClient::PlayerEvent::LevelChangedEvent
      # PlaylyfeClient::PlayerEvent::AchievementEvent
      # PlaylyfeClient::PlayerEvent::ActionPlayedEvent
      # PlaylyfeClient::PlayerEvent::CustomRuleAppliedEvent
      # PlaylyfeClient::PlayerEvent::ScoreUpdatedByAdminEvent

      



      


      
      
