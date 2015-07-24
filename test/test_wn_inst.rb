# coding: utf-8

require "minitest/autorun"
require "mywn"

# Inst = Instance
class TestWnInst < MiniTest::Test
  def setup
    @seiji_ozawa = "seiji_ozawa"
  end

  def test_wn_inst_class
    assert_kind_of Array, @seiji_ozawa.wn_inst
  end

  def test_word_match
    seiji_ozawa_inst = [
      "director"
    ]
    seiji_ozawa_inst.each do |w|
      assert_equal @seiji_ozawa.wn_inst.include?(w), true
    end
  end
end
