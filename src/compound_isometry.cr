require "./isometry"

module SymmBase
  # See `Isometry`, isometries including this module
  # get their `#transform` method from here.
  module CompoundIsometry
    include Isometry
    getter isometries : Set(Isometry)

    # Operate on the point with each isometry's transform method
    # in order, returning the resultant point.
    def transform(point : Point)
      isometries.reduce(point) { |acc, isometry| isometry.transform(acc) }
    end

    def transform(vectorlike : Vectorlike, invert = [] of Symbol)
      isometries.reduce(vectorlike) { |acc, isometry| isometry.transform(acc, invert) }
    end
  end
end
