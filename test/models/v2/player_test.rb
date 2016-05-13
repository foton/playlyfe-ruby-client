require_relative '../../playlyfe_test_class.rb'

module Playlyfe
  class PlayerTest < Playlyfe::Test

    def test_build_from_hash
      @player = Playlyfe::V2::Player.new({ "id"=> "player1", "alias"=> "player1_alias", "enabled"=> true}, nil)

      assert_equal "player1", @player.id
      assert_equal "player1_alias", @player.alias
      assert @player.enabled?
    end

    def test_is_enabled  
      assert Playlyfe::V2::Player.new({ "id"=> "player1", "alias"=> "player1_alias", "enabled"=> true}, nil).enabled?
    end  

    def test_is_disabled
      refute Playlyfe::V2::Player.new({ id: "player1", alias: "player1_alias", enabled: false}, nil).enabled?
      #default is disabled
      refute Playlyfe::V2::Player.new({ id: "player1", alias: "player1_alias"}, nil).enabled?
    end  

    def test_get_profile
      skip 
    end  

    def test_get_profile_image
      skip 
    end  

    def test_get_activity_feed
      skip 
    end  

    def test_get_notifications
      skip 
    end  

  end
end
