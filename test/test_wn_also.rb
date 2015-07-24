# coding: utf-8

require "minitest/autorun"
require "mywn"

class TestWnAlso < MiniTest::Test
  def setup
    @good = "good"
  end

  def test_wn_also_class
    assert_kind_of Array, @good.wn_also
  end

  def test_word_match
    good_also = [
      "best",
      "better",
      "favourable",
      "good",
      "obedient",
      "respectable",
      "good",
      "moral",
      "right",
      "righteous",
      "virtuous",
      "worthy"]
    good_also.each do |w|
      assert_equal @good.wn_also.include?(w), true
    end
  end
end
