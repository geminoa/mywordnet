# coding: utf-8

require "minitest/autorun"
require "mywn"

# Hsub = Holonyms - Substance
class TestWnHsub < MiniTest::Test
  def setup
    @atomic_number_8 = "atomic_number_8"
  end

  def test_wn_hsub_class
    assert_kind_of Array, @atomic_number_8.wn_hsub
  end

  def test_word_match
    atomic_number_8_hsub = [
      "water", "air", "ozone"
    ]
    atomic_number_8_hsub.each do |w|
      assert_equal @atomic_number_8.wn_hsub.include?(w), true
    end
  end
end
