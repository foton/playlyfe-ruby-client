require_relative "../leaderboard.rb"
require_relative "./players_leaderboard.rb"
require_relative "./teams_leaderboard.rb"

module PlaylyfeClient
  module V2
    class UnknownLeaderboard < PlaylyfeClient::V2::Leaderboard

      def self.create_from(lbd_hash, game)
        entity=lbd_hash[:entity_type] || lbd_hash["entity_type"]
        case entity
        when "players"
          return PlaylyfeClient::V2::PlayersLeaderboard.new(lbd_hash, game)
        when "teams"  
          return PlaylyfeClient::V2::TeamsLeaderboard.new(lbd_hash, game)
        else
          fail PlaylyfeClient::LeaderboardError.new("{\"error\": \"Unrecognized entity_type\", \"error_description\": \"Class for entity_type '#{entity}' from #{lbd_hash} is unrecognized!\"}")
        end
      end              

    end
  end
end  
