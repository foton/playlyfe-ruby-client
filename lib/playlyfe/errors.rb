require 'json'

module Playlyfe
  #grabbed from playlyfe-rub-sdk
  class Error < StandardError; end
  class ConnectionError < Playlyfe::Error; end
  class GameError < Playlyfe::Error; end
  class PlayerError < Playlyfe::Error; end
  class LeaderboardError < Playlyfe::Error; end
  class ActionError < Playlyfe::Error; end
  class MetricError < Playlyfe::Error; end
  class Playlyfe::ActionRateLimitExceededError < Playlyfe::ActionError; end

  class Error < StandardError
    attr_accessor :name, :message
    def initialize(res=nil,uri=nil)
      @raw = res
      unless res.nil? || res == ""
        res = JSON.parse(res)
        @name = res['error']
        @message = res['error_description']
        @message+=" [request: #{uri}]" unless uri.nil?
      end  
    end
    
    def self.build(res=nil,uri=nil)
      err_class= Playlyfe::ConnectionError
      unless res.nil? || res == ""
        res_h = JSON.parse(res)
        if res_h['error'] == "rate_limit_exceeded"
          err_class= Playlyfe::ActionRateLimitExceededError
        end  
      end  
      err_class.new(res, uri)
    end
  end

end
