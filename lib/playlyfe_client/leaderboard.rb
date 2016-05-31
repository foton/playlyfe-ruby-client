require_relative "./errors.rb"

module PlaylyfeClient
  class Leaderboard
    
    attr_reader :id, :name, :game, :positions
    
    def self.all(game)
      game.leaderboards
    end  
    
    def table
      positions
    end

    def results
      positions
    end

    private

      def initialize(game)
        @game =game
        @positions=[]
      end  
  end
end    
