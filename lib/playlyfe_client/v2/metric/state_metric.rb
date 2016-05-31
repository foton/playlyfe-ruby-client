require_relative "../metric.rb"

module PlaylyfeClient
  module V2
    class StateMetric < PlaylyfeClient::V2::Metric
      attr_reader :states

      private 
      
        def initialize(metric_hash, game)
          super(metric_hash, game)

          fill_states(metric_hash["states"])
        end  


        def fill_states(states_hash)
          @states=[]
          states_hash.each_pair do |key, value|
            @states << {name: key , description: value["description"]}
          end
          @states
        end 
    end
  end
end  
