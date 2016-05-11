require_relative '../playlyfe_test_class.rb'

module Playlyfe
  module V2

    #I have to verified that my stubs are in sync with real API responses
    class StubbedResponsesTest < Playlyfe::Test

      def test_verify_game_hash
        real_hash=connection.get_full_game_hash
        stubbed_hash={}
        stub_game_query { stubbed_hash=connection.get_full_game_hash }
        
        verify_stubbing(real_hash, stubbed_hash, "game_hash")
      end  

      def test_verify_players_hash
        real_hash=connection.get_full_players_hash
        stubbed_hash={}
        stub_players_query { stubbed_hash=connection.get_full_players_hash }
        
        verify_stubbing(real_hash, stubbed_hash, "players_hash")
      end  

      private


        def verify_stubbing(real_hash, stubbed_hash, what)
          assert_equal real_hash.keys.sort, stubbed_hash.keys.sort , "[#{what}] Keys are not the same: REAL #{real_hash.keys.sort}    STUBBED #{stubbed_hash.keys.sort}"
        
          real_hash.keys.each do |key|
            if real_hash[key].kind_of?(Hash)
              verify_stubbing(real_hash[key], stubbed_hash[key], "#{what}:#{key}")
            else  
              assert_equal real_hash[key], stubbed_hash[key], "[#{what}][\"#{key}\"] is '#{stubbed_hash[key]}'' but expected is '#{real_hash[key]}'"
            end  
          end 
        end  

    end
  end
end      
