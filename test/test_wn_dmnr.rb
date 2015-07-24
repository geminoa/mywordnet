# coding: utf-8

require "minitest/autorun"
require "mywn"

# Dmnr = Domain - Region
class TestWnDmnr < MiniTest::Test
  def setup
    @sake = "sake"
  end

  def test_wn_dmnr_class
    assert_kind_of Array, @sake.wn_dmnr
  end

  def test_word_match
    sake_dmnr = [
      "nippon"
    ]
    sake_dmnr.each do |w|
      assert_equal @sake.wn_dmnr.include?(w), true
    end
  end
end
