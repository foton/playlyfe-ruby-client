require_relative "../leaderboard.rb"

module Playlyfe
  module V2
    class PlayersLeaderboard < Playlyfe::V2::Leaderboard

      private 
        
        def fill_positions(data)  
          data.each do |pos|
            rank=(pos[:rank] || pos["rank"]).to_i - 1
            score=pos[:score] || pos["score"] || 0
            entity= pos[:player] || pos["player"]

            player=game.players.find(entity[:id] || entity["id"])

            #all players should be listed in game, so if nothing is found raise exception
            if player.nil?
              fail Playlyfe::LeaderboardError.new("{\"error\": \"Player not found\", \"error_description\": \"Player '#{entity[:id] || entity["id"]}' from '#{self.name}'[#{self.id}] leaderboard was not found between game.players!\"}")
            end 
      
            @positions[rank] = {entity: player, score: score}
          end  

          @positions
        end  

    end
  end
end  
