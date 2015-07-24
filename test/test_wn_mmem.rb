# coding: utf-8

require "minitest/autorun"
require "mywn"

# Mmem = Meronyms - Member
class TestWnMmem < MiniTest::Test
  def setup
    @canis = "canis"
  end

  def test_wn_mmem_class
    assert_kind_of Array, @canis.wn_mmem
  end

  def test_word_match
    canis_mmem = [
      "canis_familiaris", "wolf", "jackal"
    ]
    canis_mmem.each do |w|
      assert_equal @canis.wn_mmem.include?(w), true
    end
  end
end
