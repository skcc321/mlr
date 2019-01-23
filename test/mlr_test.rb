require "test_helper"
require "pry"

class MlrTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Mlr::VERSION
  end

  def test_it_does_multilateration_from_2D_points
    assert_equal(
      Mlr.from_points([
        Mlr::AnchorPoint2D.new(0, 100, 50),
        Mlr::AnchorPoint2D.new(100, 100, 50),
        Mlr::AnchorPoint2D.new(100, 0, 50)
      ]),
      Mlr::ResultPoint2D.new(
        59.103629855759586,
        59.10363763568137
      )
    )
  end
end
