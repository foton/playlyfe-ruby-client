require_relative "../metric.rb"

module Playlyfe
  module V2
    class SetMetric < Playlyfe::V2::Metric
      attr_reader :items

      private 
      
        def initialize(metric_hash, game)
          super(metric_hash, game)

          fill_items(metric_hash["items"] || [])
        end  

        def fill_items(items_hash)
          @items=[]
          items_hash.each_pair do |key, value|
            @items << {name: key , description: value["description"]}
          end
          @items
        end    
    end
  end
end  
