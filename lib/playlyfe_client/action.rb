require_relative "./errors.rb"

module PlaylyfeClient
  class Action

    attr_reader :game

    def self.all(game)
      game.avaliable_actions
    end  

    def play_by(player)
      player.play(self)
    end  

    def apply_rewards_on_scores(scores)
      new_scores=scores.dup 
      self.rewards.each do |reward|
        reward[:metric].apply_reward(reward, new_scores)
      end  
      new_scores  
    end
      
    private 
    
      def initialize(game)
        @game=game
      end  

  end
end    
    
