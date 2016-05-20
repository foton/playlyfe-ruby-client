require_relative "../metric.rb"

module Playlyfe
  module V2
    class SetMetric < Playlyfe::V2::Metric
      attr_reader :items

      def apply_reward(reward, scores)
        reward[:value].each do |rwd_item|
          score_item=scores[:sets][self.id.to_sym].detect { |i| i[:name] == rwd_item[:name] }
          case reward[:verb]
            when "add"
             score_item[:count]+=rwd_item[:count].to_i
            when "remove"
             score_item[:count]-=rwd_item[:count].to_i
            when "set"
             score_item[:count]=rwd_item[:count].to_i
          end
        end  
      end 



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
