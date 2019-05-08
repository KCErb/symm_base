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

    # must also support transforming anything with 3 vals in an array that respond
    # to plus, times, minus etc... but I don't know how to enforce that cleanly here
    abstract def transform(vectorlike : Vectorlike)
  end

  # what does "vectorlike" mean you ask?
  alias Vectorlike = NumericArray | Array(Float64|Int32) | Tuple(Float64, Float64, Float64) | Tuple(Int32, Int32, Int32)

  abstract struct NumericArray
    abstract def [](index : Int32) : Numberlike
  end

  abstract struct Numberlike
    alias Num = (Int32 | Float64)
    abstract def -
    abstract def +(other : self)
    abstract def +(other : Num)
    abstract def -(other : self)
    abstract def -(other : Num)
    abstract def *(other : self)
    abstract def *(other : Num)
    abstract def /(other : self)
    abstract def /(other : Num)
  end

end
