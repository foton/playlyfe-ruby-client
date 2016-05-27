require_relative "./errors.rb"

module Playlyfe
  class Player 
    
    attr_reader :game

    def self.create(player_hash, game)
      nil
    end  

    def self.all(game)
      game.players
    end  

    def play(action)
      false
    end
    
    def scores
      {points: {} ,sets: {}, states: {}, compound: {}}
    end

    def items_from_sets
      items=[]
      self.scores[:sets].each_pair do | key, value |
        value.each do |item_h|
          items << item_h.merge({metric_id: key.to_s}) if item_h[:count] > 0
        end  
      end  
      items.sort! {|a,b| a[:name] <=> b[:name]}
      items
    end      

    def badges
      self.items_from_sets
    end

    def points
      points=[]
      self.scores[:points].each_pair do | key, value |
        points << {count: value, metric_id: key.to_s}
      end
      points 
    end 

    def states
      states=[]
      self.scores[:states].each_pair do | key, value |
        states << {name: value, metric_id: key.to_s}
      end
      states 
    end  

    def levels
      self.states
    end 

    def teams
      []
    end

    def players_leaderboards
      []
    end
    
    def teams_leaderboards  
      []
    end  

    def activities(start_time=nil,end_time=nil)
      []
    end

    private 
      def initialize(game)
        @game=game
      end  
  end
end  
