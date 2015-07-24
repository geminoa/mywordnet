# coding: utf-8

require "minitest/autorun"
require "mywn"

# Enta = Entails
class TestWnEnta < MiniTest::Test
  def setup
    @fleece = "fleece"  # [["羊皮"], ["吹掛ける", "吹きかける", ... ]]
  end

  def test_wn_enta_class
    assert_kind_of Array, @fleece.wn_enta
  end

  def test_word_match
    fleece_enta = [
      "charge"
    ]
    fleece_enta.each do |w|
      assert_equal @fleece.wn_enta.include?(w), true
    end
  end
end
