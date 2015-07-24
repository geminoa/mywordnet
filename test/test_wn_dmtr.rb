# coding: utf-8

require "minitest/autorun"
require "mywn"

# Dmtr = In Domain - Region
class TestWnDmtr < MiniTest::Test
  def setup
    @nippon = "nippon"
  end

  def test_wn_dmtr_class
    assert_kind_of Array, @nippon.wn_dmtr
  end

  def test_word_match
    nippon_dmtr = [
      "harakiri",
      "sumo",
      "go_game",
      "shogi",
      "shiatsu",
      "jujutsu",
      "ninjutsu",
      "karate",
      "origami",
      "tea_ceremony",
      "futon",
      "kamikaze",
      "shoji",
      "shingon",
      "japanese",
      "ryukyuan",
      "miso",
      "wasabi",
      "sukiyaki",
      "sashimi",
      "sushi",
      "tempura",
      "sake",
      "aum_shinrikyo",
      "chukaku-ha",
      "jra",
      "yakuza",
      "diet",
      "prefecture",
      "kamikaze",
      "koto_player",
      "sumo_wrestler",
      "yakuza",
      "esaki",
      "seiji_ozawa"
    ]
    nippon_dmtr.each do |w|
      assert_equal @nippon.wn_dmtr.include?(w), true
    end
  end
end
