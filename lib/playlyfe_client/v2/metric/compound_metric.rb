require_relative "../metric.rb"

module PlaylyfeClient
  module V2
    class CompoundMetric < PlaylyfeClient::V2::Metric
      attr_reader :formula


      def apply_reward(reward, scores)
        metric_sym=self.id.to_sym
        case reward[:verb]
          when "add"
           scores[:compounds][metric_sym]+=reward[:value].to_i
          when "remove"
           scores[:compounds][metric_sym]-=reward[:value].to_i
          when "set"
           scores[:compounds][metric_sym]=reward[:value].to_i
        end
      end

      private 
      
        def initialize(metric_hash, game)
          super(metric_hash, game)
          
          @formula=metric_hash[:formula] || metric_hash["formula"]
        end  

    end
  end
end  
