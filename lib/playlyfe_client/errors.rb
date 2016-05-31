require 'json'

module PlaylyfeClient
  #grabbed from playlyfe-rub-sdk
  class Error < StandardError; end
  class ConnectionError < PlaylyfeClient::Error; end
  class GameError < PlaylyfeClient::Error; end
  class PlayerError < PlaylyfeClient::Error; end
  class LeaderboardError < PlaylyfeClient::Error; end
  class ActionError < PlaylyfeClient::Error; end
  class MetricError < PlaylyfeClient::Error; end
  class PlaylyfeClient::ActionRateLimitExceededError < PlaylyfeClient::ActionError; end
  class PlaylyfeClient::PlayerExistsError < PlaylyfeClient::PlayerError; end

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
      err_class= PlaylyfeClient::ConnectionError
      unless res.nil? || res == ""
        res_h = JSON.parse(res)
        if res_h['error'] == "rate_limit_exceeded"
          err_class= PlaylyfeClient::ActionRateLimitExceededError
        elsif res_h['error'] == "player_exists"
          err_class= PlaylyfeClient::PlayerExistsError
              
        end  
      end  
      err_class.new(res, uri)
    end
  end

end
