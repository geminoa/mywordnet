# coding: utf-8

require "minitest/autorun"
require "mywn"

class TestToJpn < MiniTest::Test
  def setup
    @cat= "cat"
  end

  def test_keys
    assert_equal @cat.to_jpn.keys, [:jpns, :synonyms, :eng, :jpn]
  end

  def test_synonyms
    assert_equal @cat.to_jpn[:synonyms][0][:eng], "true_cat"
    assert_equal @cat.to_jpn[:synonyms][0][:jpn].size, 5 
    assert_equal @cat.to_jpn[:synonyms][0][:jpn].include?("猫"), true
  end
end
