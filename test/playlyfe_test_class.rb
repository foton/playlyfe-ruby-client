require_relative "../lib/playlyfe.rb"
require_relative 'test_helper'

module Playlyfe
  #for mocking and other setups
  class Test < Minitest::Test

    #connection credentials  as they where used in RUBY SDK test for API V1 (https://github.com/playlyfe/playlyfe-ruby-sdk)
    CLIENT_ID="Zjc0MWU0N2MtODkzNS00ZWNmLWEwNmYtY2M1MGMxNGQ1YmQ4"
    CLIENT_SECRET="YzllYTE5NDQtNDMwMC00YTdkLWFiM2MtNTg0Y2ZkOThjYTZkMGIyNWVlNDAtNGJiMC0xMWU0LWI2NGEtYjlmMmFkYTdjOTI3"

    def connection
      #doing something like before(:all)
      @@con_v2 ||= Playlyfe::Connection.new(
        version: 'v2',
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        type: 'client'
      )
    end  

    def initialize(*args)
      super
      @real_calls_to_api=false #here You can switch to real calls to Playlyfe API
    end
    

  end  
end
