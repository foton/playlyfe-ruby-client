require_relative '../../playlyfe_test_class.rb'

module Playlyfe
  class ActionCollectionTest < Playlyfe::Test

    def setup
      super
      stub_game_query { @game=connection.game}
      stub_metrics_query { @game.metrics }
      stub_all_actions_query do
        @collection = Playlyfe::V2::ActionCollection.new(@game)
      end  
      
    end  

    def test_build_from_game
      assert_equal Playlyfe::Testing::ExpectedResponses.full_all_actions_array.size, @collection.size
    end  

    def test_can_find_action_by_id
       Playlyfe::Testing::ExpectedResponses.full_all_actions_array.each do |exp_action|
        actual_action=@collection.find(exp_action["id"])
        refute actual_action.nil?, "Action '#{exp_action}' was not found in collection #{@collection.to_a} by ID"
      end 
    end

    def test_can_find_action_by_name
       Playlyfe::Testing::ExpectedResponses.full_all_actions_array.each do |exp_action|
        actual_action=@collection.find(exp_action["name"])
        refute actual_action.nil?, "Action '#{exp_action}' was not found in collection #{@collection.to_a} by NAME"
      end 
    end
    
    def test_can_convert_to_array  
      assert @collection.to_a.kind_of?(Array)
      assert_equal Playlyfe::Testing::ExpectedResponses.full_all_actions_array.size, @collection.to_a.size
    end
    
    def test_can_return_all
      assert_equal @collection.to_a , @collection.all
    end  
   

  end
end
