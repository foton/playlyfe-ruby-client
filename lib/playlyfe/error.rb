require 'json'

module Playlyfe
  #grabbed from playlyfe-rub-sdk
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
  end
end
