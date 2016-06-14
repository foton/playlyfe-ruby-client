require_relative "../leaderboard.rb"

module PlaylyfeClient
  module V2
    class PlayersLeaderboard < PlaylyfeClient::V2::Leaderboard

      private 
        
        def fill_positions(data)  
          #preproces data into new_data
          new_data=[]

          data.each do |pos|
            rank=(pos[:rank] || pos["rank"]).to_i
            score=pos[:score] || pos["score"]
            entity= pos[:player] || pos["player"]

            player=game.players.find(entity[:id] || entity["id"])

            #all players should be listed in game, so if nothing is found raise exception
            if player.nil?
              fail PlaylyfeClient::LeaderboardError.new("{\"error\": \"Player not found\", \"error_description\": \"Player '#{entity[:id] || entity["id"]}' from '#{self.name}'[#{self.id}] leaderboard was not found between game.players!\"}")
            end 
      
            new_data << {rank: rank, entity: player, score: score}
          end  
          
          super(new_data)
        end  

    end
  end
end  
