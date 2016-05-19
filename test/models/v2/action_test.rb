require_relative '../../playlyfe_test_class.rb'

module Playlyfe
  class ActionTest < Playlyfe::Test
  
    def setup
      stub_game_query { @game=connection.game}
      stub_metrics_query { @game.metrics }
      stub_all_actions_query { @game.available_actions }
      stub_players_query { @game.players }  
      stub_teams_query { @game.teams }

      @player = @game.players.find("player1")
      @action_hash=Playlyfe::Testing::ExpectedResponses.get_hammer_screwdriver_and_plus_point_action_hash
      @action = @game.available_actions.find(@action_hash["id"])
    end 



    def test_build_from_mixed_metric_hash
      action_h=@action_hash
      action=Playlyfe::V2::Action.new( action_h, @game)

      ["id","name","variables", "description" ].each do |key|
        real_value=action.send(key)  
        expected_value=action_h[key]
        assert_equal expected_value, real_value, "Action '#{action_h["id"]}' has #{key.upcase} = '#{real_value}' instead expected '#{expected_value}'."
      end
      assert_equal action_h["count"], action.times_played

      assert_equal action_h["rewards"].size, action.rewards.size
      action_h["rewards"].each do |exp_rwd|
        if exp_rwd["metric"]["type"] == "set"
          check_reward_from_set(exp_rwd, action.rewards)
        else
          check_other_reward_types(exp_rwd, action.rewards)
        end  
      end    
      
    end  

    def test_play_action
      skip
      expected_value = {}
      real_value = @action.play_by(@player)
    end  


    private

      def check_reward_from_set(exp_rwd, real_rewards)
        name=exp_rwd["value"].keys.first
        exp_id="#{exp_rwd["metric"]["id"]}_#{name}".underscore
        real_rwd=real_rewards.detect {|r| r[:id] == exp_id}

        refute  real_rwd.nil? , "Expected reward '#{exp_id}' was not found in real action.rewards: #{real_rewards.collect {|r| r[:id]}}"
        assert_equal name, real_rwd[:value].first[:name]
        assert_equal exp_rwd["value"][name].to_i, real_rwd[:value].first[:count]
        assert_equal exp_rwd["verb"], real_rwd[:verb]
        assert_equal exp_rwd["probability"], real_rwd[:probability]
      end
        
      def check_other_reward_types(exp_rwd, real_rewards)
        exp_id="#{exp_rwd["metric"]["id"]}_#{exp_rwd["value"]}".underscore
        real_rwd=real_rewards.detect {|r| r[:id] == exp_id}

        refute  real_rwd.nil? , "Expected reward '#{exp_id}' was not found in real action.rewards: #{real_rewards.collect {|r| r[:id]}}"
        assert_equal exp_rwd["value"].to_i , real_rwd[:value]
        assert_equal exp_rwd["verb"], real_rwd[:verb]
        assert_equal exp_rwd["probability"], real_rwd[:probability]
      end
      
  end
end
