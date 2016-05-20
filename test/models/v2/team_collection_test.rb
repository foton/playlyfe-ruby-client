require_relative '../../playlyfe_test_class.rb'

module Playlyfe
  class TeamCollectionTest < Playlyfe::Test

    def setup
      super
      stub_game_query do
        @game=connection.game
      end
      #we need players for team.owner
      stub_players_query do
        @game.players
      end  

      stub_teams_query do
        @collection = Playlyfe::V2::TeamCollection.new(@game)
      end  
    end  

    def test_build_from_game
      assert_equal Playlyfe::Testing::ExpectedResponses.team_hash_array.size, @collection.size
    end  

    def test_can_find_team_by_id
      Playlyfe::Testing::ExpectedResponses.team_hash_array.each do |exp_team|
        actual_team=@collection.find(exp_team["id"])
        refute actual_team.nil?, "Team '#{exp_team}' was not found in collection #{@collection} by ID"
      end 
    end

    def test_can_find_team_by_name
      Playlyfe::Testing::ExpectedResponses.team_hash_array.each do |exp_team|
        actual_team=@collection.find(exp_team["name"])
        refute actual_team.nil?, "Team '#{exp_team}' was not found in collection #{@collection} by NAME"
      end 
    end
    
    def test_can_convert_to_array  
      assert @collection.to_a.kind_of?(Array)
      assert_equal Playlyfe::Testing::ExpectedResponses.team_hash_array.size, @collection.to_a.size
    end
    
    def test_can_return_all
      assert_equal @collection.to_a , @collection.all
    end  
   

  end
end
