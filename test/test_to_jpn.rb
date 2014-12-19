# coding: utf-8

require "minitest/autorun"
require "mywn"

class TestJpn < MiniTest::Unit::TestCase
  def setup
    @word = "dog"
  end

  def test_to_jpn
    assert_equal @word, "dog"
  end
end
