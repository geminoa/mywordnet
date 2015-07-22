# coding: utf-8

require "minitest/autorun"
require "mywn"

# Holonyms - Member = 被構成要素(構成員)
class TestWnHmem< MiniTest::Test
  def setup
    @canis = "canis_familiaris"  # ["飼い犬", "ドッグ", "犬", "飼犬", "洋犬", "イヌ"]
  end

  def test_wn_hmem
    assert_kind_of Array, @canis.wn_hmem
    assert_equal @canis.wn_hmem, ["canis", "pack"]  # 肉食動物
  end
end
