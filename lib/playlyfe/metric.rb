require_relative "./errors.rb"

module Playlyfe
 class Metric
   attr_reader :game

   private

    def initialize(game)
      @game=game
    end  

 end
end   
