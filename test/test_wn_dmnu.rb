# coding: utf-8

require "minitest/autorun"
require "mywn"

# Dmnu = Domain - Usage
class TestWnDmnu < MiniTest::Test
  def setup
    @jean = "jean"
  end

  def test_wn_dmnu_class
    assert_kind_of Array, @jean.wn_dmnu
  end

  def test_word_match
    jean_dmnu = [
      "plural_form"
    ]
    jean_dmnu.each do |w|
      assert_equal @jean.wn_dmnu.include?(w), true
    end
  end
end
