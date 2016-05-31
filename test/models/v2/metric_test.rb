require_relative '../../playlyfe_test_class.rb'

module PlaylyfeClient
  class MetricTest < PlaylyfeClient::Test

    def setup
      super
      stub_game_query { @game=connection.game}
    end  

    def test_create_point_metric_from_hash
      exp_metric_hash=PlaylyfeClient::Testing::ExpectedResponses.point_metric_hash1
      metric=PlaylyfeClient::V2::Metric.create_from(exp_metric_hash,@game)

      assert metric.kind_of?(PlaylyfeClient::V2::PointMetric)
      ["id","name","type","description"].each do |key|
        real_value=metric.send(key)  
        expected_value=exp_metric_hash[key]
        assert_equal expected_value, real_value, "Point metric '#{exp_metric_hash["id"]}' has #{key.upcase} = '#{real_value}' instead expected '#{expected_value}'."
      end
    end  

    def test_create_compound_metric_from_hash
      exp_metric_hash=PlaylyfeClient::Testing::ExpectedResponses.compound_metric_hash
      metric=PlaylyfeClient::V2::Metric.create_from(exp_metric_hash,@game)

      assert metric.kind_of?(PlaylyfeClient::V2::CompoundMetric)
      ["id","name","type","description","formula"].each do |key|
        real_value=metric.send(key)  
        expected_value=exp_metric_hash[key]
        assert_equal expected_value, real_value, "Compound metric '#{exp_metric_hash["id"]}' has #{key.upcase} = '#{real_value}' instead expected '#{expected_value}'."
      end
    end  

    def test_create_set_metric_from_hash
      exp_metric_hash=PlaylyfeClient::Testing::ExpectedResponses.set_metric_hash
      metric=PlaylyfeClient::V2::Metric.create_from(exp_metric_hash,@game)

      assert metric.kind_of?(PlaylyfeClient::V2::SetMetric)
      ["id","name","type","description"].each do |key|
        real_value=metric.send(key)  
        expected_value=exp_metric_hash[key]
        assert_equal expected_value, real_value, "Set metric '#{exp_metric_hash["id"]}' has #{key.upcase} = '#{real_value}' instead expected '#{expected_value}'."
      end

      assert_equal exp_metric_hash["items"].size, metric.items.size
      metric.items.each do |item|
        refute exp_metric_hash["items"][item[:name]].nil?
        assert_equal exp_metric_hash["items"][item[:name]]["description"], item[:description]
      end  
    end

    def test_create_state_metric_from_hash
      exp_metric_hash=PlaylyfeClient::Testing::ExpectedResponses.state_metric_hash
      metric=PlaylyfeClient::V2::Metric.create_from(exp_metric_hash,@game)

      assert metric.kind_of?(PlaylyfeClient::V2::StateMetric)
      ["id","name","type","description"].each do |key|
        real_value=metric.send(key)  
        expected_value=exp_metric_hash[key]
        assert_equal expected_value, real_value, "State metric '#{exp_metric_hash["id"]}' has #{key.upcase} = '#{real_value}' instead expected '#{expected_value}'."
      end

      assert_equal exp_metric_hash["states"].size, metric.states.size
      metric.states.each do |state|
        refute exp_metric_hash["states"][state[:name]].nil?
        assert_equal exp_metric_hash["states"][state[:name]]["description"], state[:description]
      end  
    end  

   

  end
end
