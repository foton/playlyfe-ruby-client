require_relative "./errors.rb"

module PlaylyfeClient
  class Action

    attr_reader :game

    def self.all(game)
      game.avaliable_actions
    end  

    def play_by(player, variables_for_play ={})
      @variables_for_play=variables_for_play
      fail_if_variables_are_wrong

      begin
        game.connection.post_play_action(self.id, player.id, { "variables" => variables_for_play})
      rescue PlaylyfeClient::ActionRateLimitExceededError   => e
        unless game.ignore_rate_limit_errors  
          fail e
        end
      end  
    end  

    def apply_rewards_on_scores(scores)
      new_scores=scores.dup 
      self.rewards.each do |reward|
        reward[:metric].apply_reward(reward, new_scores)
      end  
      new_scores  
    end
      
    def variables
      []  
    end 

    def required_variables
      []  
    end 

    private 
    
      def initialize(game)
        @game=game
      end  

      def fail_if_variables_are_wrong
        #not implemented here
      end
  end
end    
    
