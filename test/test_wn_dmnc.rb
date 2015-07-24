# coding: utf-8

require "minitest/autorun"
require "mywn"

# Dmnc = Domain - Category 
class TestWnDmnc < MiniTest::Test
  def setup
    @comet = "comet"
  end

  def test_wn_dmnc_class
    assert_kind_of Array, @comet.wn_dmnc
  end

  def test_word_match
    comet_dmnc = [
      "astronomy"
    ]
    comet_dmnc.each do |w|
      assert_equal @comet.wn_dmnc.include?(w), true
    end
  end
end
