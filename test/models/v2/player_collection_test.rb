require_relative '../../playlyfe_test_class.rb'

module Playlyfe
  class PlayerCollectionTest < Playlyfe::Test

    def setup
      stub_game_query do
        @game=connection.game
      end
     
      stub_players_query do
        @collection = Playlyfe::V2::PlayerCollection.new(@game)
      end
    end  

    def test_build_from_game
      assert_equal expected_player_hash_array.size, @collection.size
    end  

    def test_can_find_player_by_id
      expected_player_hash_array.each do |exp_player|
        actual_player=@collection.find(exp_player["id"]).first
        refute actual_player.nil?, "Player '#{exp_player}' was not found in collection #{@collection} by ID"
      end 
    end

    def test_can_find_player_by_alias
      expected_player_hash_array.each do |exp_player|
        actual_player=@collection.find(exp_player["alias"]).first
        refute actual_player.nil?, "Player '#{exp_player}' was not found in collection #{@collection} by ALIAS"
      end 
    end
    
    def test_can_convert_to_array  
      assert @collection.to_a.kind_of?(Array)
      assert_equal expected_player_hash_array.size, @collection.to_a.size
    end
    
    def test_can_return_all
      assert_equal @collection.to_a , @collection.all
    end  
   

  end
end
