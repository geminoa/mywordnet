# coding: utf-8

require "minitest/autorun"
require "mywn"

class TestWnCaus < MiniTest::Test
  def setup
    @project = "project"
  end

  def test_wn_caus_class
    assert_kind_of Array, @project.wn_caus
  end

  def test_word_match
    project_caus = [
      "appear"
    ]
    project_caus.each do |w|
      assert_equal @project.wn_caus.include?(w), true
    end
  end
end
