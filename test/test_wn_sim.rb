# coding: utf-8

require "minitest/autorun"
require "mywn"

# Sim = Similar to
class TestWnSim < MiniTest::Test
  def setup
    @white = "white"
  end

  def test_wn_sim_class
    assert_kind_of Array, @white.wn_sim
  end

  def test_word_match
    white_sim = [
      "albescent",
      "caucasoid",
      "light-skinned",
      "pure",
      "covered",
      "segregated",
      "hot",
      "good",
      "empty",
      "diluted",
      "colourless",
      "colourless",
      "light"
    ]
    white_sim.each do |w|
      assert_equal @white.wn_sim.include?(w), true
    end
  end
end
