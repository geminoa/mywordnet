# coding: utf-8

require "minitest/autorun"
require "mywn"

class TestWnAttr < MiniTest::Test
  def setup
    @value = "value"
  end

  def test_wn_attr_class
    assert_kind_of Array, @value.wn_attr
  end

  def test_word_match
    value_attr = [
      "black", "white", "light", "dark"
    ]
    value_attr.each do |w|
      assert_equal @value.wn_attr.include?(w), true
    end
  end
end
