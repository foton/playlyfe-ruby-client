require_relative "../metric.rb"

module Playlyfe
  module V2
    class CompoundMetric < Playlyfe::V2::Metric
      attr_reader :formula
      private 
      
        def initialize(metric_hash, game)
          super(metric_hash, game)
          
          @formula=metric_hash[:formula] || metric_hash["formula"]
        end  

    end
  end
end  
