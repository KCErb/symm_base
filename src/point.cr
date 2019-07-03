require "./vector3"

module SymmBase
  # Provides an abstract parent struct for "points" which are one of the base
  # objects that isometries operate on (see `Isometry`).
  #
  # Essentially, this struct just wraps a `Vector3` so that the point represented
  # by that vector can have some kind of internal state. You'll notice that
  # the nature of the `invert` method restricts us to two-state points for now.
  abstract struct Point
    # The `Vector3` for this Point.
    property coordinates : Vector3

    # Creates new point with coordinates.
    def initialize(@coordinates : Vector3); end

    # Returns the result of calling this method on `#coordinates`.
    delegate x, y, z, values, to: @coordinates

    # Handles an isometry's request to `invert` some property specified by Symbol.
    #
    # Implementing classes should handle calls for their own state and ignore
    # others instead of raising an error.
    #
    # This assumes implementing classes will only need the name of the property
    # to know what to do, for example:
    #
    # ```
    # class MyPoint
    #   # code for defining the point and its state
    #   # ...
    #   def invert(symbol)
    #     if symbol == :my_state
    #       # do something to update the state of this point
    #     end
    #   end
    # end
    # ```
    def invert(symbol : Symbol); end

    abstract def clone
    abstract def ==(other : self)
  end
end
