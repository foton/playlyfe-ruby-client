require_relative '../../playlyfe_test_class.rb'

module PlaylyfeClient
  class PlayerCollectionTest < PlaylyfeClient::Test

    def setup
      super
      stub_game_query do
        @game=connection.game
      end
     
      stub_players_query do
        @collection = PlaylyfeClient::V2::PlayerCollection.new(@game)
      end
    end  

    def test_build_from_game
      assert_equal PlaylyfeClient::Testing::ExpectedResponses.player_hash_array.size, @collection.size
    end  

    def test_can_find_player_by_id
      PlaylyfeClient::Testing::ExpectedResponses.player_hash_array.each do |exp_player|
        actual_player=@collection.find(exp_player["id"])
        refute actual_player.nil?, "Player '#{exp_player}' was not found in collection #{@collection} by ID"
      end 
    end

    def test_can_find_player_by_alias
      PlaylyfeClient::Testing::ExpectedResponses.player_hash_array.each do |exp_player|
        actual_player=@collection.find(exp_player["alias"])
        refute actual_player.nil?, "Player '#{exp_player}' was not found in collection #{@collection} by ALIAS"
      end 
    end
    
    def test_can_find_all_players_by_id
      exp_ids=(PlaylyfeClient::Testing::ExpectedResponses.player_hash_array.collect {|exp_player| exp_player["id"]})[0..-2] #not select ALL players
      actual= @collection.find_all(exp_ids)
      assert_equal (exp_ids.size), actual.size
      assert_equal exp_ids.sort, (actual.collect {|player| player.id}).sort
    end

    def test_can_find_all_players_by_alias
      exp_aliases=(PlaylyfeClient::Testing::ExpectedResponses.player_hash_array.collect {|exp_player| exp_player["alias"]})[0..-2] #not select ALL players
      actual= @collection.find_all(exp_aliases)
      assert_equal (exp_aliases.size), actual.size
      assert_equal exp_aliases.sort, (actual.collect {|player| player.alias}).sort
    end

    def test_can_convert_to_array  
      assert @collection.to_a.kind_of?(Array)
      assert_equal PlaylyfeClient::Testing::ExpectedResponses.player_hash_array.size, @collection.to_a.size
    end
    
    def test_can_return_all
      assert_equal @collection.to_a , @collection.all
    end  

    def test_can_iterate_on_items
      rounds=0
      @collection.each do |p|
        rounds+=1
      end  
      assert_equal @collection.to_a.size, rounds
    end  
   

  end
end
