require_relative "../leaderboard.rb"

module Playlyfe
  module V2
    class TeamsLeaderboard < Playlyfe::V2::Leaderboard

      private 
        
        def fill_positions(data)  
          data.each do |pos|
            rank=(pos[:rank] || pos["rank"]).to_i - 1
            score=pos[:score] || pos["score"] || 0
            entity= pos[:team] || pos["team"]

            team=game.teams.find(entity[:id] || entity["id"])

            #all teams should be listed in game, so if nothing is found raise exception
            if team.nil?
              fail Playlyfe::LeaderboardError.new("{\"error\": \"Team not found\", \"error_description\": \"Team '#{entity[:id] || entity["id"]}' from '#{self.name}'[#{self.id}] leaderboard was not found between game.teams!\"}")
            end 

            @positions[rank] = {entity: team, score: score}
          end  

          @positions
        end  

    end
  end
end  
