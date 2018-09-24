require "./point"

module SymmBase
  # Provides a common type for [isometries](https://en.wikipedia.org/wiki/Isometry).
  module Isometry
    abstract def transform(point : Point) : Point
  end
end
