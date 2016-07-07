require_relative "../action.rb"

module PlaylyfeClient
  module V2
    class Action < PlaylyfeClient::Action
      attr_reader :id, :name, :description, :rewards, :variables, :times_played

      def required_variables
        @required_variables||=variables.select {|v| v["required"]}
      end  

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

        def fail_if_variables_are_wrong  
          return true if self.variables.empty?

          missing_variables=[]
          wrong_variables=[]

          self.variables.each do |v|
            vfp=@variables_for_play[v["name"]] || @variables_for_play[v["name"].to_sym]
            if vfp.nil? 
              if self.required_variables.include?(v)
                missing_variables << v
              end  
            else
              unless check_type_of_variable_for_play(v,vfp)  
                wrong_variables << [v,vfp]
              end
            end    
          end  

          unless missing_variables.empty?
            fail PlaylyfeClient::ActionPlayedWithoutRequiredVariables.new("{\"error\": \"missing_required_variables\", \"error_description\": \"The Action '#{self.id}' can only be played with required variables [#{self.required_variables.collect {|v| "'#{v["name"]}'"}.join(", ")}].\"}", "") 
          end
          
          unless wrong_variables.empty?  
            list=wrong_variables.collect {|wv| "'#{wv.first["name"]}[#{wv.first["type"]}] => #{wv.last}'"}
            fail PlaylyfeClient::ActionPlayedWithWrongVariables.new("{\"error\": \"variables_have_wrong_types\", \"error_description\": \"Given variables for action '#{self.id}' have wrong types [#{list.join(", ")}].\"}", "") 
          end  
        end  

        def check_type_of_variable_for_play(v,vfp)  
          case v["type"] 
          when "int"
            vfp.kind_of?(Integer)
          when "string"
            vfp.kind_of?(String)
          else
            false
          end  
        end  


    end  
  end  
end

     
