require_relative '../../../playlyfe_test_class.rb'

module PlaylyfeClient
  class TeamEventTest < PlaylyfeClient::Test
      # PlaylyfeClient::V2::TeamEvent::TeamCreatedEvent
      # PlaylyfeClient::V2::TeamEvent::RequestToJoinEvent
      # PlaylyfeClient::V2::TeamEvent::JoinAcceptedEvent
      # PlaylyfeClient::V2::TeamEvent::JoinRejectedEvent
      # PlaylyfeClient::V2::TeamEvent::InviteSendEvent
      # PlaylyfeClient::V2::TeamEvent::InviteAcceptedEvent
      # PlaylyfeClient::V2::TeamEvent::InviteRejectedEvent
      # PlaylyfeClient::V2::TeamEvent::JoinedEvent
      # PlaylyfeClient::V2::TeamEvent::RolesChangedEvent  #own or other member
      # PlaylyfeClient::V2::TeamEvent::RequestForChangeOfRolesEvent
      # PlaylyfeClient::V2::TeamEvent::ChangeOfRolesAcceptedEvent
      # PlaylyfeClient::V2::TeamEvent::ChangeOfRolesRejectedEvent
      # PlaylyfeClient::V2::TeamEvent::KickedOutEvent
      # PlaylyfeClient::V2::TeamEvent::LeavedEvent
      # PlaylyfeClient::V2::TeamEvent::TeamDeletedEvent
      # PlaylyfeClient::V2::TeamEvent::TeamOwnershipTransferredEvent

    def setup
      stub_game_query { @game=connection.game}
      stub_metrics_query { @game.metrics }
      stub_all_actions_query { @game.available_actions }
      stub_players_query { @game.players }  
      stub_teams_query { @game.teams }
    end  


    ["request_to_join",
      "join_accepted",
      "join_rejected",
      "invite_send",
      "invite_rejected",
      "joined",
      "own_roles_changed",
      "request_for_roles_change",
      "request_for_roles_change_accepted",
      "request_for_roles_change_rejected",
      "kicked_out",
      "leaved",
      "team_delete",
      "team_ownership_transfered"
    ].each do |ev_name|
      define_method("test_can_build_team_#{ev_name}_event") do
        skip "do not have JSON from Playlyfe for this event. Yet."
      end 
    end  

   
    def test_can_build_team_create_event
      event=PlaylyfeClient::V2::TeamEvent::Base.build( team_create_event_hash, @game)

      assert event.kind_of?(PlaylyfeClient::V2::TeamEvent::TeamCreatedEvent)
      
      assert_equal "player1", event.actor_id
      assert_equal "player1_alias", event.actor_alias
      assert_equal @game.players.find("player1"), event.actor
     
      assert_equal "team_57349f7b7d0ed66b0193101f", event.team_id
      assert_equal "Team1 for RUby client", event.team_name
      assert_equal @game.teams.find("Team1 for RUby client"), event.team

      assert_equal Time.utc(2016,5,12,15,21,31.418).to_f, event.timestamp.to_f
      assert_equal 0, event.roles.size
    end 

 
    def test_can_build_invite_accepted_event_from_full_hash
      event=PlaylyfeClient::V2::TeamEvent::Base.build(invite_accepted_full_hash, @game)

      verify_invite_accepted_event(event)
    end

    def test_can_build_invite_accepted_event_from_team_activity_feed
      ev_hash=invite_accepted_full_hash.dup
      ev_hash.delete("team")
      assert ev_hash["team"].nil?

      event=PlaylyfeClient::V2::TeamEvent::Base.build(invite_accepted_full_hash, @game, @game.teams.find("Team1 for RUby client"))

      verify_invite_accepted_event(event)
    end

    def test_can_build_invite_accepted_event_from_actor_activity_feed
      ev_hash=invite_accepted_full_hash.dup
      ev_hash.delete("actor") #target of invitation; "player2"
      assert ev_hash["actor"].nil?

      event=PlaylyfeClient::V2::TeamEvent::Base.build(invite_accepted_full_hash, @game, @game.players.find("player2"))

      verify_invite_accepted_event(event)
    end

    def test_can_build_invite_accepted_event_from_inviter_activity_feed
      ev_hash=invite_accepted_full_hash.dup
      ev_hash.delete("inviter") #target of invitation; "player1"
      assert ev_hash["inviter"].nil?

      event=PlaylyfeClient::V2::TeamEvent::Base.build(invite_accepted_full_hash, @game, @game.players.find("player1"))

      verify_invite_accepted_event(event)
    end

    def test_can_build_roles_changed_event_from_role_assign_hash
      ev_hash={
        "event" => "role:assign",
        "timestamp" => "2016-05-17T10:10:54.086Z",
        "player" => { "id" => "player1", "alias" => "player1_alias"},
        "team" =>  { "id" => "team_57349f7b7d0ed66b0193101f", "name" => "Team1 for RUby client" },  #not present in team activity feed!
        "changes" => {
          "Sergeant" => { "old" => nil, "new" => true }
        },
        "actor" => { "id" => "player3", "alias" => "player3_alias" },
        "id" => "a3e46a61-1c17-11e6-8344-47b85380947e"
      }

      event=PlaylyfeClient::V2::TeamEvent::Base.build(ev_hash, @game)

      assert event.kind_of?(PlaylyfeClient::V2::TeamEvent::RolesChangedEvent)
      
      assert_equal "player3", event.actor_id
      assert_equal "player3_alias", event.actor_alias
      assert_equal @game.players.find("player3"), event.actor
      
      assert_equal "player1", event.player_id
      assert_equal "player1_alias", event.player_alias
      assert_equal @game.players.find("player1"), event.player
      
      assert_equal "team_57349f7b7d0ed66b0193101f", event.team_id
      assert_equal "Team1 for RUby client", event.team_name
      assert_equal @game.teams.find("Team1 for RUby client"), event.team

      assert_equal Time.utc(2016,5,17,10,10,54.0860002).to_f, event.timestamp.to_f
      assert_equal 1, event.changes.size
      assert_equal ["Sergeant"], event.roles
    end  


    private
    
      def invite_accepted_full_hash
        { 
          "event" => "invite:accept",
          "timestamp" => "2014-03-02T12:34:34.474Z",
          "actor" => {"id" => "player2", "alias" => "player2_alias" }, #not present in invited player activity feed!
          "inviter" => {"id" => "player1", "alias" => "player1_alias" }, #not present in inviter activity feed!
          "team" =>  { "id" => "team_57349f7b7d0ed66b0193101f", "name" => "Team1 for RUby client" },  #not present in team activity feed!
          "roles" => { "Sergeant" => true },
          "id" => "02aefca0-a207-11e3-b0b2-6be1ca7db7ba"
        }
      end  

      def verify_invite_accepted_event(event)
        assert event.kind_of?(PlaylyfeClient::V2::TeamEvent::InviteAcceptedEvent)
        
        assert_equal "player2", event.actor_id
        assert_equal "player2_alias", event.actor_alias
        assert_equal @game.players.find("player2"), event.actor
        
        assert_equal "player1", event.inviter_id
        assert_equal "player1_alias", event.inviter_alias
        assert_equal @game.players.find("player1"), event.inviter
        
        assert_equal "team_57349f7b7d0ed66b0193101f", event.team_id
        assert_equal "Team1 for RUby client", event.team_name
        assert_equal @game.teams.find("Team1 for RUby client"), event.team

        assert_equal Time.utc(2014,3,2,12,34,34.474).to_f, event.timestamp.to_f
        assert_equal 1, event.roles.size
        assert_equal ["Sergeant"], event.roles
      end  
    
  end
end    
