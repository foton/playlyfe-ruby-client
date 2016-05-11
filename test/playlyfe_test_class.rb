require_relative "../lib/playlyfe.rb"
require_relative 'test_helper'

module Playlyfe
  #for mocking and other setups
  class Test < Minitest::Test

    #connection credentials  as they where used in RUBY SDK test for API V1 (https://github.com/playlyfe/playlyfe-ruby-sdk)
    #CLIENT_ID="Zjc0MWU0N2MtODkzNS00ZWNmLWEwNmYtY2M1MGMxNGQ1YmQ4"
    #CLIENT_SECRET="YzllYTE5NDQtNDMwMC00YTdkLWFiM2MtNTg0Y2ZkOThjYTZkMGIyNWVlNDAtNGJiMC0xMWU0LWI2NGEtYjlmMmFkYTdjOTI3"
    
    #connection to my Game for Ruby client 
    CLIENT_ID="OWM5YzlmMGYtZGM2Yy00MGE3LWEwYTUtMmFkMDM2MWM0Yzhk"
    CLIENT_SECRET="ZTY0ZDg2OTgtNDk5Ni00NGE4LThhZWUtYjhhY2M1MDNlNTdlNTVlMDM1OTAtMTFlYy0xMWU2LThlYjItZGY5NGM0NDllZjMx"
    
    def connection
      #doing something like before(:all)
      @@con_v2 ||= Playlyfe::V2::Connection.new(
        version: 'v2',
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        type: 'client'
      )
    end  

    #here you can switch responses for API versions
    require_relative "./expected_responses/v2.rb"
    include ExpectedResponses

    def initialize(*args)
      super
      #@real_calls_to_api=false #here You can switch to real calls to Playlyfe API
    end
    
    def stub_game_query &block
      connection.stub :get_full_game_hash, full_game_hash do 
        yield 
      end
    end  

    def stub_players_query &block
      connection.stub :get_full_players_hash, full_players_hash do 
        yield 
      end
    end  

  end  
end
