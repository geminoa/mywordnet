# coding: utf-8

require "minitest/autorun"
require "mywn"

# Holonyms - Part = 構成要素(部分)
class TestWnHprt < MiniTest::Test
  def setup
    @flag = "flag"  # ["フラグ", "のぼり", "旗幟",...]
  end

  def test_wn_hprt
    assert_kind_of Array, @flag.wn_hprt
    [
      "cervid",  # ["鹿", "シカ", "牡鹿"]
      "canis_familiaris"  # ["飼い犬", "ドッグ", "犬", "飼犬", "洋犬", "イヌ"]
    ].each do |w|
      p w, @flag.wn_hprt
      assert_equal @flag.wn_hprt.include?(w), true
    end
  end
end
