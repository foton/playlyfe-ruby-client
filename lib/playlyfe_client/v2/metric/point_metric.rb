require_relative "../metric.rb"

module PlaylyfeClient
  module V2
    class PointMetric < PlaylyfeClient::V2::Metric

      def apply_reward(reward, scores)
        metric_sym=self.id.to_sym
        case reward[:verb]
          when "add"
           scores[:points][metric_sym]+=reward[:value].to_i
          when "remove"
           scores[:points][metric_sym]-=reward[:value].to_i
          when "set"
           scores[:points][metric_sym]=reward[:value].to_i
        end
      end

      private 
      
        def initialize(metric_hash, game)
          super(metric_hash, game)
        end  

    end
  end
end  
