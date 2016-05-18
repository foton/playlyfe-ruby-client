require_relative "./errors.rb"

module Playlyfe
  class Leaderboard
    
    attr_reader :id, :name, :game, :positions
    
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
