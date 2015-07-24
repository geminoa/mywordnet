# coding: utf-8

require "minitest/autorun"
require "mywn"

# Hasi = Has Instance
class TestWnHasi < MiniTest::Test
  def setup
    @director = "director"
  end

  def test_wn_hasi_class
    assert_kind_of Array, @director.wn_hasi
  end

  def test_word_match
    director_hasi = [
      "granville-barker",
      "elia_kazan",
      "stanislavsky",
      "ingmar_bergman",
      "luis_bunuel",
      "alfred_joseph_hitchcock",
      "strasberg",
      "leonard_bernstein",
      "edward_benjamin_britten",
      "arthur_fiedler",
      "paul_hindemith",
      "koussevitzky",
      "leonard_constant_lambert",
      "gustav_mahler",
      "ormandy",
      "seiji_ozawa",
      "leopold_antoni_stanislaw_stokowski",
      "george_szell",
      "arturo_toscanini",
      "walter",
      "weber",
      "sir_henry_joseph_wood"
    ]
    director_hasi.each do |w|
      assert_equal @director.wn_hasi.include?(w), true
    end
  end
end
