require_relative '../../playlyfe_test_class.rb'

module PlaylyfeClient
  class ActionTest < PlaylyfeClient::Test
  
    def setup
      super
      stub_game_query { @game=connection.game}
      stub_metrics_query { @game.metrics }
      stub_all_actions_query { @game.available_actions }
      stub_players_query { @game.players }  
      stub_teams_query { @game.teams }

      @player = @game.players.find("player1")
      @action_hash=PlaylyfeClient::Testing::ExpectedResponses.get_hammer_screwdriver_and_plus_point_action_hash
      @action = @game.available_actions.find(@action_hash["id"])
    end 

    def test_build_from_mixed_metric_hash
      action_h=@action_hash
      action=PlaylyfeClient::V2::Action.new( action_h, @game)

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
      action_id= "get_hammer_screwdriver_and_plus_point"
      action=@game.available_actions.find(action_id)

      expected_after_scores, player_after_profile_hash = prepare_scores_after_action_play(@player, action)
      real_after_scores={}        
      
      
      stub_play_action(action_id, PlaylyfeClient::Testing::ExpectedResponses.full_play_action_hammer_screwdriver_and_plus_point_hash) do
        #after action is played, updated player's profile is requested
        stub_player_profile_query(player_after_profile_hash) do
          action.play_by(@player)
          real_after_scores=@player.scores
        end  
      end

      assert_equal expected_after_scores, real_after_scores

      assert_equal expected_after_scores[:sets].size, real_after_scores[:sets].size
      assert_equal expected_after_scores[:states].size, real_after_scores[:states].size
      assert_equal expected_after_scores[:compounds].size, real_after_scores[:compounds].size

      assert_equal expected_after_scores[:points][:plus_points], real_after_scores[:points][:plus_points]
      assert_equal expected_after_scores[:points][:test_points], real_after_scores[:points][:test_points]
      assert_equal [        
                   {name: "Multitool", count: 1},
                   {name: "Hammer", count: 2}, 
                   {name: "Screwdriver", count: 2} 
                  ], real_after_scores[:sets][:toolbox]
      assert_equal expected_after_scores[:states][:experience], real_after_scores[:states][:experience]
      assert_equal expected_after_scores[:compounds][:compound_metric], real_after_scores[:compounds][:compound_metric]
    end  

    def test_action_knows_its_variables
      action_id= "get_hammer_screwdriver_and_plus_point"
      action=@game.available_actions.find(action_id)
      assert_equal [], action.variables
      assert_equal [], action.required_variables

      action_id= "set_test_points_to_value"
      expected_variables_array= [{ "default" => 0, "name" => "tst_p", "required" => true,"type" => "int" },
            { "default" => "default_string_value", "name" => "useless_variable", "required" => false, "type" => "string" }
          ]
      action=@game.available_actions.find(action_id)
      assert_equal 2, action.variables.size
      assert_equal expected_variables_array, action.variables
      assert_equal 1, action.required_variables.size
      assert_equal "tst_p", action.required_variables.first["name"]
    end  

    def test_do_not_play_action_without_required_variables
      action_id= "set_test_points_to_value"
      action=@game.available_actions.find(action_id)
      
      #should not hit connection, this is security stub
      stub_play_action(action_id, PlaylyfeClient::Testing::ExpectedResponses.full_play_action_hammer_screwdriver_and_plus_point_hash) do
        e=assert_raises(PlaylyfeClient::ActionPlayedWithoutRequiredVariables) { action.play_by(@player) }
  
        expected_error=PlaylyfeClient::ActionPlayedWithoutRequiredVariables.new("{\"error\": \"missing_required_variables\", \"error_description\": \"The Action '#{action_id}' can only be played with required variables ['tst_p'].\"}", "") 
        assert_equal expected_error.name, e.name
        assert_equal expected_error.message.gsub(/access_token=\w*/,""), e.message.gsub(/access_token=\w*/,"")
      end   
    end  

    def test_do_not_play_action_with_variables_of_wrong_types
      action_id= "set_test_points_to_value"
      action=@game.available_actions.find(action_id)
      
      #should not hit connection, this is security stub
      stub_play_action(action_id, PlaylyfeClient::Testing::ExpectedResponses.full_play_action_hammer_screwdriver_and_plus_point_hash) do
        e=assert_raises(PlaylyfeClient::ActionPlayedWithWrongVariables) { action.play_by(@player, {tst_p: 12, useless_variable: 1}) }

        expected_error=PlaylyfeClient::ActionPlayedWithWrongVariables.new("{\"error\": \"variables_have_wrong_types\", \"error_description\": \"Given variables for action '#{action_id}' have wrong types ['useless_variable[string] => 1'].\"}", "") 
        assert_equal expected_error.name, e.name
        assert_equal expected_error.message.gsub(/access_token=\w*/,""), e.message.gsub(/access_token=\w*/,"")
      end   
    end  

    def test_play_action_with_variables
      action_id= "set_test_points_to_value"
      action=@game.available_actions.find(action_id)

      mock = MiniTest::Mock.new
      args=[:post, "/runtime/actions/#{action_id}/play", {player_id: @player.id}, PlaylyfeClient::Testing::ExpectedResponses.set_test_points_action_play_request,false]
      mock.expect(:call, {}, args)      
      
      @game.connection.stub(:api, mock) do
        action.play_by(@player, PlaylyfeClient::Testing::ExpectedResponses.set_test_points_action_play_request["variables"]) 
      end  
      mock.verify
    end 


    def test_apply_rewards_on_scores
      action_id= "get_hammer_screwdriver_and_plus_point"
      action=@game.available_actions.find(action_id)
      scores ={
        points: {test_points: 0, plus_points:0},
        states: {},
        compounds: {},
        sets: { toolbox: [
                      {name: "Hammer", count: 0}, 
                      {name: "Screwdriver", count: 0}, 
                      {name: "Multitool", count: 0}
                     ]
              }
      }

      new_scores= @action.apply_rewards_on_scores(scores)
      
      refute new_scores.nil?
      assert_equal ["plus_points_1", "toolbox_hammer", "toolbox_screwdriver"], (action.rewards.collect {|rwd| rwd[:id]}).sort
      assert_equal 1, new_scores[:points][:plus_points]
      assert_equal 0, new_scores[:points][:test_points]
      assert_equal [
                    {name: "Hammer", count: 1}, 
                    {name: "Screwdriver", count: 1}, 
                    {name: "Multitool", count: 0}
                   ], new_scores[:sets][:toolbox]
    end  


    def test_raise_error_when_rate_limit_is_exceed
      action_id= "get_hammer_screwdriver_and_plus_point"
      action=@game.available_actions.find(action_id)
      stubbed_response= PlaylyfeClient::ActionRateLimitExceededError.new("{\"error\": \"rate_limit_exceeded\", \"error_description\": \"The Action '#{action_id}' can only be triggered 1 times every day\"}", "") 

      #DEFAULT: @game.ignore_rate_limit_errors=false
      connection.stub(:post_play_action, -> (action_id, player_id, body) { raise stubbed_response }) do
        e=assert_raises(PlaylyfeClient::ActionRateLimitExceededError) { action.play_by(@player) }
  
        expected_error=stubbed_response
        assert_equal expected_error.name, e.name
        assert_equal expected_error.message.gsub(/access_token=\w*/,""), e.message.gsub(/access_token=\w*/,"")
      end   
    end  

    def test_silently_ignore_error_when_rate_limit_is_exceed
      action_id= "get_hammer_screwdriver_and_plus_point"
      action=@game.available_actions.find(action_id)
      before_scores= stub_player_profile_query(PlaylyfeClient::Testing::ExpectedResponses.full_profile_hash_for_player1) { @player.scores }
      stubbed_response= PlaylyfeClient::ActionRateLimitExceededError.new("{\"error\": \"rate_limit_exceeded\", \"error_description\": \"The Action '#{action_id}' can only be triggered 1 times every day\"}", "") 

      #NON-DEFAULT just pretend no action was played
      @game.ignore_rate_limit_errors=true

      connection.stub(:post_play_action, -> (action_id, player_id, body) { raise stubbed_response }) do
        #e=assert_raises(PlaylyfeClient::ActionRateLimitExceededError) { action.play_by(@player) }
        #nothing should be raised
        action.play_by(@player)

        assert_equal before_scores, @player.scores
      end   
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

      def prepare_scores_after_action_play(player, action)
        case player.id 
        when "player1"
          player_profile=PlaylyfeClient::Testing::ExpectedResponses.full_profile_hash_for_player1
        else  
          raise "Stubb is set only for 'player1', not for '#{player.id}'" 
        end

        #doing deep_dup (so no refferences to original frozen object)
        player_profile=Marshal.load(Marshal.dump(player_profile))
        
        before_scores={}
        stub_player_profile_query(player_profile) do
          before_scores = player.scores
        end  
        updated_scores = action.apply_rewards_on_scores(before_scores)
                
        updated_scores[:points].each_pair do |metric_id, value|
          score=player_profile["scores"].detect {|s| s["metric"]["id"] == metric_id.to_s}
          score["value"]=value.to_s
        end  

        updated_scores[:compounds].each_pair do |metric_id, value|
          score=player_profile["scores"].detect {|s| s["metric"]["id"] == metric_id.to_s}
          score["value"]=value.to_s
        end  

        updated_scores[:states].each_pair do |metric_id, value|
          score=player_profile["scores"].detect {|s| s["metric"]["id"] == metric_id.to_s}
          score["value"]["name"]=value.to_s
        end  

        updated_scores[:sets].each_pair do |metric_id, values|
          score=player_profile["scores"].detect {|s| s["metric"]["id"] == metric_id.to_s}
          score_values=score["value"]
          values.each do |item_h|
            s_item_h=score_values.detect {|sv| sv["name"] == item_h[:name]}
            s_item_h["count"]=item_h[:count].to_s
          end  
        end  

        return updated_scores, player_profile
      end  
      
  end
end
