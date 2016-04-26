require_relative './test_helper'

class MinitestTest < Minitest::Test
  
  def setup
    @abc=1
  end

  def test_abc_setup
    assert_equal 1, @abc
  end

  def test_abc_setup_failure
    #assert_equal 2, @abc
  end
end

#class ConnectionTest < ActiveSupport::TestCase
