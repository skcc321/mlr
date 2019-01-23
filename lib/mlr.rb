require "mlr/strategy/python"
require "mlr/version"

module Mlr
  class Error < StandardError; end

  # define point struct
  # it is used everywhere
  AnchorPoint3D = Struct.new(:x, :y, :z, :distance)

  AnchorPoint2D = Struct.new(:x, :y, :distance) do
    def z; 0; end
  end

  ResultPoint2D = Struct.new(:x, :y)
  ResultPoint3D = Struct.new(:x, :y, :z)

  # modes
  MODE2D = '2D'.freeze
  MODE3D = '3D'.freeze

  # sorvers
  SOLVER_LSE = 'LSE'.freeze

  # STRATEGIES
  PYTHON = 'python'.freeze
  STRATEGY = PYTHON

  DETECT_MODE = ->(points) {
    if points.all? { |point| point.is_a?(Mlr::AnchorPoint2D) }
      Mlr::MODE2D
    elsif points.all? { |point| point.is_a?(Mlr::AnchorPoint3D) }
      Mlr::MODE3D
    end
  }

  # strategy selector
  def self.strategy
    case STRATEGY
    when PYTHON then Mlr::Strategy::Python
    end
  end

  # interface
  def self.from_array(array)
    points = array.map do |line|
      case line.size
      when 3 then Mlr::AnchorPoint2D.new(*line)
      when 4 then Mlr::AnchorPoint3D.new(*line)
      else
        raise 'wrong number of elements in array'
      end
    end

    from_points(points)
  end

  def self.from_points(points)
    strategy.get_point(points: points, mode: DETECT_MODE.call(points))
  end
end
