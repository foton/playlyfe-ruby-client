require_relative "../leaderboard.rb"

module Playlyfe
  module V2
    class Leaderboard < Playlyfe::Leaderboard
      
      attr_reader :entity_type, :metric, :scope, :cycles

      private 
      
        def initialize(lbd_hash, game)
          super(game)

          @id=lbd_hash[:id] || lbd_hash["id"]
          @name=lbd_hash[:name] || lbd_hash["name"]
          @entity_type=lbd_hash[:entity_type] || lbd_hash["entity_type"]
          @metric=lbd_hash[:metric] || lbd_hash["metric"]
          @scope=lbd_hash[:scope] || lbd_hash["scope"]
          @cycles=lbd_hash[:cycles] || lbd_hash["cycles"]

          fill_positions(lbd_hash[:data] || lbd_hash["data"] || [])
        end
        
        def fill_positions(data)  
          data.each do |pos|
            rank=(pos[:rank] || pos["rank"]).to_i - 1
            score=pos[:score] || pos["score"] || 0
            entity= pos[:player] || pos["player"] || pos[:team] || pos["team"] || nil
            
            @positions[rank] = {entity: entity, score: score}
          end  

          @positions
        end  

    end
  end
end  
