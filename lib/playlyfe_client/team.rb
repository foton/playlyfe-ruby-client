require_relative "./errors.rb"

module PlaylyfeClient
  class Team
    
    attr_reader :id, :name, :created_at, :game, :connection

    def template
      definition
    end
    
    def members
      []
    end

    def leaderboards
      []
    end

    def events
      []
    end  

    private

      def initialize(game)
        @game =game
      end  
  end
end    
