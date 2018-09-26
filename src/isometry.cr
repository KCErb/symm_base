require "./point"

module SymmBase
  # Provides a common type for [isometries](https://en.wikipedia.org/wiki/Isometry).
  #
  # You can turn your class into an Isometry like so:
  #
  # ```
  # class MyIsometry
  #   include SymmBase::Isometry
  #
  #   def initialize
  #     @kind = :my_isometry
  #   end
  #
  #   def transform(point)
  #     # Do something to the point, or not, up to you.
  #     # Just be sure to return a point when you're done
  #   end
  # end
  # ```
  #
  # At the moment, this base module just requires that you give a transform
  # method and initialize the `@kind` variable. There is no actual enforcement
  # that the transform method preserves any metrics.
  module Isometry
    getter kind : Symbol

    abstract def transform(point : Point) : Point

    # Transforms a `Set` of points according to the class's
    # `transform` method.
    def transform(points : Set(Point))
      points.map { |point| transform(point) }.to_set
    end
  end
end
