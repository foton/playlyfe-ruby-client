require_relative "./errors.rb"

module Playlyfe
  class Action

    attr_reader :game

    def self.all(game)
      game.avaliable_actions
    end  

    def play(player)
      nil
    end  

    private 
      def initialize(game)
        @game=game
      end  

  end
end    
    
