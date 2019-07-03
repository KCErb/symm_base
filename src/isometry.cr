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
  # At the moment, this base module requires that you give two transform
  # methods and initialize the `@kind` variable. There is no actual enforcement
  # that the transform method preserves any metrics.
  #
  # The transform methods must define operation on a `Point` and a `Vectorlike` object. The
  # `@kind` is just a symbol to aid in identification and uniqueness.
  module Isometry
    getter kind : Symbol

    # Transform one instance of a `Point` into a new `Point` based on logic
    # implemented by including class.
    abstract def transform(point : Point) : Point

    # Transforms a `Set` of points according to the class's
    # `transform` method.
    def transform(points : Set(Point))
      points.map { |point| transform(point) }.to_set
    end

    # Transform a `Vectorlike` into a new `Vectorlike` object based
    # on same logic as `Point`.
    abstract def transform(vectorlike : Vectorlike) : Vectorlike

    # Optionally, pass an array of symbols to the transform method which
    # handle how a transform is changed based on the properties of the vectorlike
    # object.
    def transform(vectorlike : Vectorlike, invert = [] of Symbol) : Vectorlike
      transform(vectorlike)
    end
  end
end
