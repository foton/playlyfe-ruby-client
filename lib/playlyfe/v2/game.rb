
#require_relative "./player.rb"
#require_relative "./action.rb"
#require_relative "./ledaderboard.rb"


module Playlyfe
  module V2
    #Game is 1:1 to connection, so only one instance per connection
    #finding is done by credentials
    class Game
          
      def self.find_by_connection(conn)
        @game=conn.get('/admin')
      end  

      def players
      end
      
      def actions
      end

      def leaderboards
      end

    end
  end  
end    
