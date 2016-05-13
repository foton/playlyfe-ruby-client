require_relative '../../playlyfe_test_class.rb'

module Playlyfe
  class TeamTest < Playlyfe::Test

    def setup
      stub_game_query do
        @game=connection.game
      end
      #we need players for team.owner
      stub_players_query do
        @game.players
      end  

      @exp_team_hash=expected_team1_hash
      @team = Playlyfe::V2::Team.new(@exp_team_hash, @game)
    end  


    def test_build_from_hash
      ["id","name","access","game_id","definition"].each do |key|
        real_value=@team.send(key)  
        expected_value=@exp_team_hash[key]
        assert_equal expected_value, real_value, "Team '#{@exp_team_hash["id"]}' has #{key.upcase} = '#{real_value}' instead expected '#{expected_value}'."
      end

      real_value=@team.created_at
      expected_value=Time.parse(@exp_team_hash["created"])
      assert_equal expected_value, real_value, "Team '#{@exp_team_hash["id"]}' has CREATED_AT = '#{real_value}' instead expected '#{expected_value}'."

      real_value=@team.owner
      expected_value=@game.players.find(@exp_team_hash["owner"]["id"])
      refute (expected_value.nil? || expected_value.empty?)
      assert_equal expected_value, real_value, "Team '#{@exp_team_hash["id"]}' has OWNER = '#{real_value}' instead expected '#{expected_value}'."


      real_value=@team.roles.sort
      expected_value=@exp_team_hash["roles"].sort
      assert_equal expected_value, real_value, "Team '#{@exp_team_hash["id"]}' has ROLES = '#{real_value}' instead expected '#{expected_value}'."
    end  

    def test_get_template
      assert_equal @team.definition, @team.template
    end
    
    def test_get_members
      skip
    end

    def test_get_team_leaderboards
      skip
    end  
    

  end
end
