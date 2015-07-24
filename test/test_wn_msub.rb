# coding: utf-8

require "minitest/autorun"
require "mywn"

# Msub = Meronyms - Substance
class TestWnMsub < MiniTest::Test
  def setup
    @ozone = "ozone"
  end

  def test_wn_msub_class
    assert_kind_of Array, @ozone.wn_msub
  end

  def test_word_match
    ozone_msub = [
      "atomic_number_8"
    ]
    ozone_msub.each do |w|
      assert_equal @ozone.wn_msub.include?(w), true
    end
  end
end
