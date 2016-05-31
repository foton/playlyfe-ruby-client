require_relative "../metric.rb"

module PlaylyfeClient
  module V2
    class Metric < PlaylyfeClient::Metric
     
      attr_reader :id, :name, :type, :description

      def self.create_from(metric_hash,game)  
        require_relative "./metric/compound_metric.rb" 
        require_relative "./metric/point_metric.rb" 
        require_relative "./metric/set_metric.rb" 
        require_relative "./metric/state_metric.rb" 
        
        type=metric_hash[:type] || metric_hash["type"]
        case type
        when "set"
          PlaylyfeClient::V2::SetMetric.new(metric_hash,game)
        when "state"
          PlaylyfeClient::V2::StateMetric.new(metric_hash,game)
        when "point"
          PlaylyfeClient::V2::PointMetric.new(metric_hash,game)
        when "compound"
          PlaylyfeClient::V2::CompoundMetric.new(metric_hash,game)
        else
          fail PlaylyfeClient::MetricError.new("{\"error\": \"Unrecognized type\", \"error_description\": \"Class for metric type: '#{type}' from #{metric_hash} is unrecognized!\"}")
        end        

      end  

      def apply_reward(reward, scores)
        fail PlaylyfeClient::MetricError.new("{\"error\": \"Rewards can not be applyed!\", \"error_description\": \"For these metric, direct action rewards cannot be applied. Probably some rules based awards are used.\"}")
      end

      private 
      
        def initialize(metric_hash, game)
          super(game)
          @id=metric_hash[:id] || metric_hash["id"]
          @name=metric_hash[:name] || metric_hash["name"]
          @type=metric_hash[:type] || metric_hash["type"]
          @description=metric_hash[:description] || metric_hash["description"]
        end  

    end
  end
end  
