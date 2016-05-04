
require_relative "./errors.rb"

module Playlyfe
  #Game is 1:1 to connection, so only one instance per connection
  class Game
    
    attr_reader :name, :title

    
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
