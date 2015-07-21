# coding: utf-8

require "minitest/autorun"
require "mywn"

class TestWnMprt < MiniTest::Test
  def setup
    @human = "human"  # 人間 
  end

  def test_wn_mprt
    assert_kind_of Array, @human.wn_mprt
    human_mprt = [
      "loin",  # 腰, 腰肉
      "material_body", # 人体, 人身
      "body_hair",  # 体毛
      "head_of_hair", # 頭髪
      "human_head",  # 頭
      "human_foot",  # 足
      "arm",         # 腕
      "mitt",        # 手
      "human_face"   # 顔
    ]
    human_mprt.each do |hm|
      assert_equal @human.wn_mprt.include?(hm), true
    end
  end
end
