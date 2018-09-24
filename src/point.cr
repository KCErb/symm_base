require "./vector3"

module SymmBase
  # Wraps `Vector3` so that the point represented by that vector can have
  # some kind of internal state.
  abstract struct Point
    # The `Vector3` for this Point.
    property coordinates : Vector3

    # creates new point with coordinates `@coordinates`
    def initialize(@coordinates : Vector3); end

    # Returns the result of calling this method on `#coordinates`.
    delegate x, y, z, values, to: @coordinates

    # Handles an isometry's request to `invert` some property specified by Symbol.
    #
    # Implementing classes should handle calls for their own state and ignore
    # others instead of raising an error.
    #
    # This assumes implementing classes will only need the name of the property
    # to know what to do for example `chiral` would flip between left and right
    # `charge` between plus and minus, `spin` between clockwise and counterclockwise.
    # It's really up to the implementing class.
    def invert(symbol : Symbol); end

    abstract def clone
    abstract def ==(other : self)
  end
end
