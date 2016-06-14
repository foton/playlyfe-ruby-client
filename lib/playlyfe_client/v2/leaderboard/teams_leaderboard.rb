require_relative "../leaderboard.rb"

module PlaylyfeClient
  module V2
    class TeamsLeaderboard < PlaylyfeClient::V2::Leaderboard

      private 
        
        def fill_positions(data)  
          #preproces data into new_data
          new_data=[]

          data.each do |pos|
            rank=(pos[:rank] || pos["rank"]).to_i
            score=pos[:score] || pos["score"]
            entity= pos[:team] || pos["team"]

            team=game.teams.find(entity[:id] || entity["id"])

            #all teams should be listed in game, so if nothing is found raise exception
            if team.nil?
              fail PlaylyfeClient::LeaderboardError.new("{\"error\": \"Team not found\", \"error_description\": \"Team '#{entity[:id] || entity["id"]}' from '#{self.name}'[#{self.id}] leaderboard was not found between game.teams!\"}")
            end 
            
            new_data << {rank: rank, entity: team, score: score}
          end  
          
          super(new_data)
        end  

    end
  end
end  
