require_relative "../metric.rb"

module Playlyfe
  module V2
    class PointMetric < Playlyfe::V2::Metric
      private 
      
        def initialize(metric_hash, game)
          super(metric_hash, game)
        end  

    end
  end
end  
