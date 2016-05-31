require_relative "./errors.rb"

module PlaylyfeClient
 class Metric
   attr_reader :game

   private

    def initialize(game)
      @game=game
    end  

 end
end   
