require_relative "./errors.rb"

module Playlyfe
  class Player 
    
    attr_reader :game

    def self.all(game)
      game.players
    end  

    def play(action)
      false
    end
    
    def scores
      {points: {} ,sets: {}, states: {}, compound: {}}
    end
      
    def badges
      []
    end

    def points
      {}
    end 

    def levels
      []
    end 

    def teams
      []
    end

    private 
      def initialize(game)
        @game=game
      end  
  end
end  
