require_relative "./errors.rb"

module Playlyfe
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

    private

      def initialize(game)
        @game =game
      end  
  end
end    
