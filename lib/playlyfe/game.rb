#require_relative "./connection.rb"
require_relative "./v2/game.rb"

module Playlyfe
  #Game is 1:1 to connection, so only one instance per connection
  #finding is done by credentials
  class Game
    
    def self.find_by_connection(conn)
      if conn.api_version == "v2"
        Playlyfe::V2::Game.find_by_connection(conn)
      else
        raise "unsupported version of API #{conn.api_version}"
      end  
      game=conn.get('/admin')
    end  

    def players
    end
    
    def actions
    end

    def leaderboards
    end

  end
end    
