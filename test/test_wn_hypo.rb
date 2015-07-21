# coding: utf-8

require "minitest/autorun"
require "mywn"

class TestWnHypo < MiniTest::Test
  def setup
    @mutt = "mutt"  # 駄犬, 雑種犬
  end

  def test_wn_hypo
    assert_kind_of Array, @mutt.wn_hypo
    assert_equal @mutt.wn_hypo.include?("fice"), true   # 小型の雑種犬, 怒りっぽい雑種, 薄汚い犬
    assert_equal @mutt.wn_hypo.include?("pie-dog"), true  # "パリア", "パリア犬", "パイ" 
  end
end
