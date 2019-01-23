require 'pycall'

module Mlr
  module Strategy
    class Python
      SCRIPT = <<~PYTHON
        import localization as lx
        P=lx.Project(mode='%{mode}',solver='%{solver}')
        %{anchors}
        t,label=P.add_target()
        %{measures}
        P.solve()
      PYTHON

      def self.get_point(options)
        new(options).run
      end

      def initialize(points:, mode: Mlr::MODE2D, solver: Mlr::SOLVER_LSE)
        @points = points
        @mode = mode
        @solver = solver
      end

      def run
        # run python script
        PyCall.exec(SCRIPT % options)

        # get result from python
        make_point(PyCall.eval('t.loc'))
      end

      def options
        {
          anchors: get_anchors,
          measures: get_measures,
          mode: get_mode,
          solver: get_solver
        }
      end

      private

        def make_point(point)
          case @mode
          when Mlr::MODE2D
            Mlr::ResultPoint2D.new(point.x, point.y)
          when Mlr::MODE3D
            Mlr::ResultPoint3D.new(point.x, point.y, point.z)
          else
            raise 'incompatible mode'
          end
        end

        def result_point
          case @mode
          when Mlr::MODE2D then Mlr::ResultPoint2D
          when Mlr::MODE3D then Mlr::ResultPoint3D
          else
            raise 'incompatible mode'
          end
        end

        def get_mode
          case @mode
          when Mlr::MODE2D then '2D'
          when Mlr::MODE3D then '3D'
          else
            raise 'incompatible mode'
          end
        end

        def get_solver
          case @solver
          when Mlr::SOLVER_LSE then "LSE"
          else
            raise 'incompatible solver'
          end
        end

        def get_anchors
          @points.map.with_index do |point, index|
            "P.add_anchor('point_#{index}',(#{point.x},#{point.y},#{point.z}))"
          end.join(';')
        end

        def get_measures
          @points.map.with_index do |point, index|
            "t.add_measure('point_#{index}',#{point.distance})"
          end.join(';')
        end
    end
  end
end
