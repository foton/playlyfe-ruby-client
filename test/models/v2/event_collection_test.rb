require_relative '../../playlyfe_test_class.rb'

module PlaylyfeClient
  class ActivityCollectionTest < PlaylyfeClient::Test

    def setup
      super
      stub_game_query { @game=connection.game}
      stub_players_query { @game.players}
      stub_teams_query { @game.teams}
    end  
  
    def test_can_create_from_array
      collection = PlaylyfeClient::V2::EventCollection.new(@game, game_event_hash_array)
      assert_equal game_event_hash_array.size, collection.size
    end  

    def test_can_set_correct_event_classes
      collection = PlaylyfeClient::V2::EventCollection.new(@game, game_event_hash_array)
#      assert_equal collection.to_s.select {|e| e.class = PlaylyfeClient::Event:: game_event_hash_array.size, collection.size
    end  

    def test_can_create_from_game
      collection=[]
      stub_game_events(PlaylyfeClient::Testing::ExpectedResponses.game_events_array) do 
        collection=PlaylyfeClient::V2::EventCollection.new(@game)
      end

      assert_equal PlaylyfeClient::Testing::ExpectedResponses.game_events_array.size, collection.size
    end   

    def test_cannot_do_find
       collection = PlaylyfeClient::V2::EventCollection.new(@game, game_event_hash_array)
  
       e=assert_raises(PlaylyfeClient::CollectionFindOneIsNotSupportedError) {collection.find("xx")}
  
       assert_equal "Find item is not supported", e.name
       assert_equal "This collections has no unique key, so no use for collection.find.", e.message
    end  

    def test_can_convert_to_array  
      collection = PlaylyfeClient::V2::EventCollection.new(@game, game_event_hash_array)
      assert collection.to_a.kind_of?(Array)
      assert_equal game_event_hash_array.size, collection.to_a.size
    end
    
    def test_can_return_all
      collection = PlaylyfeClient::V2::EventCollection.new(@game, game_event_hash_array)
      assert_equal collection.to_a , collection.all
    end    

    private

      def game_event_hash_array
        [
          level_up_event_hash,
          achievement_event_hash,
          team_create_event_hash
        ]  
      end  
  end
end
