# coding: utf-8

require "minitest/autorun"
require "mywn"

class TestJpn < MiniTest::Unit::TestCase
  def setup
    @word = "dog"
  end

  # [TODO] メソッドの中身をちゃんと書く
  def test_to_jpn
    assert_equal @word, "dog"
  end

  #[TODO] 他のメソッドのテストを追加
end
