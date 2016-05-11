require_relative '../../playlyfe_test_class.rb'

module Playlyfe
  class PlayerTest < Playlyfe::Test

    def test_have_id
      assert_equal "player1", Playlyfe::V2::Player.new({ "id"=> "player1", "alias"=> "player1_alias", "enabled"=> true}, nil).id
    end
    
    def test_have_alias
      binding.pry
      assert_equal "player1_alias", Playlyfe::V2::Player.new({ "id"=> "player1", "alias"=> "player1_alias", "enabled"=> true}, nil).alias
    end

    def test_is_enabled  
      assert Playlyfe::V2::Player.new({ "id"=> "player1", "alias"=> "player1_alias", "enabled"=> true}, nil).enabled?
    end  

    def test_is_disabled
      refute Playlyfe::V2::Player.new({ id: "player1", alias: "player1_alias", enabled: false}, nil).enabled?
    end  

    def test_find_by_id
      skip 
    end  

    def test_get_profile
      skip 
    end  

    def test_update_profile
      skip 
    end  

    def test_get_profile_image
      skip 
    end  

    def test_update_profile_image
      skip 
    end  

    def test_get_activity_feed
      skip 
    end  

    def test_get_notification_token
      skip 
    end  

    def test_get_notifications
      skip 
    end  

    def test_set_notification_as_read
      skip 
    end  

    def test_get_notification_token
      skip 
    end  
   
    def get_pending_approvals
      skip
    end  

    def get_pending_invitations
      skip
    end

    def accept_an_invitation
      skip
    end

    def reject_an_invitation
      skip
    end

  end
end
