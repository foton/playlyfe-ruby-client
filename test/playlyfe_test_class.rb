require_relative "../lib/playlyfe.rb"
require_relative 'test_helper'

module Playlyfe

  #here you can switch stubbed/expected responses for API versions
  require_relative "./stubbed_api/v2_expected_responses.rb"
  #require_relative "./stubbed_api/v1_expected_responses.rb"

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
    
    require_relative "./stubbed_api/stubbed_querries.rb"
    include StubbedQuerries

    def initialize(*args)
      puts("#{self.class} init ")

      #puts(" #{Playlyfe::Testing::ExpectedResponses.full_profile_hash_for_player1["scores"][3]}")
      #raise "je #{Playlyfe::Testing::ExpectedResponses.full_profile_hash_for_player1["scores"][3]["value"]} a ma byt 13" if Playlyfe::Testing::ExpectedResponses.full_profile_hash_for_player1["scores"][3]["value"].to_i != 13
      super
    end

    def setup
      connection.reset_game!
      connection.dummy_player_id="player1"
    end  

  end  
end
