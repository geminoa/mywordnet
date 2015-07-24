# coding: utf-8

require "minitest/autorun"
require "mywn"

# Dmtc = In Domain - Category 
class TestWnDmtc < MiniTest::Test
  def setup
    @astronomy = "astronomy"
  end

  def test_wn_dmtc_class
    assert_kind_of Array, @astronomy.wn_dmtc
  end

  def test_word_match
    astronomy_dmtc = [
      "active",
      "quiet",
      "direct",
      "retrograde",
      "superior",
      "inferior",
      "nebular",
      "phase",
      "absolute_magnitude",
      "hubble's_law",
      "kepler's_law_of_planetary_motion",
      "copernican_system",
      "ptolemaic_system",
      "ascension",
      "emersion",
      "immersion",
      "alignment",
      "inferior_conjunction",
      "superior_conjunction",
      "oort_cloud",
      "galaxy",
      "point_of_apoapsis",
      "node",
      "equinox",
      "vernal_equinox",
      "autumnal_equinox",
      "barycenter",
      "culmination",
      "limb",
      "point_of_periapsis",
      "anomaly",
      "dec",
      "ra",
      "asterism",
      "canal",
      "coma",
      "comet",
      "meteor",
      "nucleus",
      "outer_planet",
      "major_planet",
      "primary",
      "star",
      "stargazer",
      "variation",
      "red_shift",
      "accretion",
      "libration",
      "nucleosynthesis",
      "orbital_plane",
      "hour_angle",
      "inclination",
      "mean_time",
      "tdt",
      "date_of_reference",
      "uprise",
      "set",
      "stargaze"
    ]
    astronomy_dmtc.each do |w|
      assert_equal @astronomy.wn_dmtc.include?(w), true
    end
  end
end
