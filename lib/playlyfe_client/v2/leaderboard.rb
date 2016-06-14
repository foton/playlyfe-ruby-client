require_relative "../leaderboard.rb"

module PlaylyfeClient
  module V2
    class Leaderboard < PlaylyfeClient::Leaderboard
      
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
        
        #positions[x] is array of entities
        #If there are 3 entities at rank 4, there will be array with 3 items at positions[3]
        #Positions[4] and positions[5] will be []
        #Playlyfe have this style of ranking too ( #1, #2, #3, #4, #4, #4, #7)
        def fill_positions(data)  
          data.each do |pos|
            rank=(pos[:rank]).to_i - 1
            score=pos[:score] || 0
            entity= pos[:entity] || nil
            
            if @positions[rank].nil?
              @positions[rank] = [{entity: entity, score: score}]
            else
              @positions[rank] << {entity: entity, score: score}
            end  
          end  

          #fill empty positions with []
          @positions.each_with_index {|p,i| @positions[i]=[] if p.nil? }

          @positions
        end  

    end
  end
end  
