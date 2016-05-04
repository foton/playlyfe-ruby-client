require_relative "../lib/playlyfe.rb"

module Playlyfe
  #for mocking and other setups
  class Test < Minitest::Test
    
    def initialize(*args)
      super
      @real_calls_to_api=false #here You can switch to real calls to Playlyfe API
    end
    
    



    #@game = Playlyfe::Game.new

  end  
end
