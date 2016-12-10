# coding: utf-8

require "minitest/autorun"
require "mywn"

class TestToEng < MiniTest::Test
  def setup
    @neko = "猫"
  end

  def test_to_eng
    assert_kind_of Hash, @neko.to_en
    assert_equal @neko.to_en.keys, [:eng, :engs, :synonyms, :jpn]
  end

  def test_synonyms
    assert_equal @neko.to_en[:synonyms][2][:jpn], "キャット"
    assert_equal @neko.to_en[:synonyms][2][:eng].size, 2
    assert_equal @neko.to_en[:synonyms][2][:eng].include?("cat"), true
  end
end
