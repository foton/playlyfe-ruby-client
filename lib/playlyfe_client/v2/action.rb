require_relative "../action.rb"

module PlaylyfeClient
  module V2
    class Action < PlaylyfeClient::Action
      attr_reader :id, :name, :description, :rewards, :variables, :times_played

      private

        def initialize(action_hash, game)
          super(game)

          @id=action_hash[:id] || action_hash["id"]
          @name=action_hash[:name] || action_hash["name"]
          @description=action_hash[:description] || action_hash["description"]
          @variables=action_hash[:variables] || action_hash["variables"]
          @times_played=action_hash[:count] || action_hash["count"] || action_hash[:times_played] || action_hash["times_played"]

          fill_rewards(action_hash[:rewards] || action_hash["rewards"] || [])
        end
        
        def fill_rewards(rewards)  
          @rewards = []
          rewards.each do |rwd_hash|
            verb= rwd_hash[:verb] || rwd_hash["verb"]
            probability= rwd_hash[:probability] || rwd_hash["probability"]

            mtr=rwd_hash[:metric] || rwd_hash["metric"]
            metric=game.metrics.find(mtr[:id] || mtr["id"])

            value=rwd_hash[:value] || rwd_hash["value"]
            if metric.kind_of?(PlaylyfeClient::V2::SetMetric)
              value=get_rewards_array(value,metric)
              id="#{metric.id}_#{(value.collect {|i| i[:name]}).join("_").underscore}"
            else
              value=value.to_i  
              id="#{metric.id}_#{value}"
            end  

            @rewards << {id: id, metric: metric, value: value, verb: verb, probability: probability }
          end  

          @rewards
        end  

        def get_rewards_array(items_hash,metric)
          items=[]
          items_hash.each_pair do |key, val|
             m_item= (metric.items.detect {|it| it[:name] == key})
             items << {name: m_item[:name], count: val.to_i} unless m_item.nil?
          end  
          items
        end

    end  
  end  
end

     
