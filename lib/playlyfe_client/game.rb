
require_relative "./errors.rb"

module PlaylyfeClient
  #Game is 1:1 to connection, so only one instance per connection
  class Game
    
    attr_reader :title, :connection

    
    def to_hash
      @game_hash || {}
    end 

    def players
      []
    end
    
    def actions
      []
    end

    def leaderboards
      []
    end

    private

      def initialize(conn)
        @connection=conn
      end  
  end
end    
