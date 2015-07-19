# coding: utf-8

require "minitest/autorun"
require "mywn"

class TestWnHype < MiniTest::Test
  def setup
    @canid = "canid"  # イヌ科動物
  end

  def test_wn_hype
    assert_kind_of Array, @canid.wn_hype
    assert_equal @canid.wn_hype, "carnivore"  # 肉食動物
  end
end
