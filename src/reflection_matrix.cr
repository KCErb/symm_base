module SymmBase
  # Matrix for reflecting a point through a plane which contains the origin and is normal to
  # the `Vector3` provided in the `#initialize` method. The operation is defined
  # in the `#*` method so that it can be used via multiplication.
  #
  # For example
  # ```
  # matrix = ReflectionMatrix.new(Vector3.new(1, 1, 1))
  # vec = Vector3.new(1, 1, 1)
  # matrix * vec # => [-1, -1, -1]
  class ReflectionMatrix
    # pre-computed matrix elements
    @a_11 : Float64
    @a_22 : Float64
    @a_33 : Float64
    @a_12 : Float64
    @a_13 : Float64
    @a_23 : Float64

    # Creates a `ReflectionMatrix` which reflects either a `Vector3` or some other
    # `Vectorlike` through a plane which contains the origin and is normal to `vec`.
    def initialize(vec : Vector3)
      x, y, z = vec.normalized.values
      @a_11 = 1 - 2*x**2
      @a_22 = 1 - 2*y**2
      @a_33 = 1 - 2*z**2
      @a_12 = -2*x*y
      @a_13 = -2*x*z
      @a_23 = -2*y*z
    end

    # Reflect `Vector3` through the plane defined by `#initialize` and return a new `Vector3`.
    def *(vec : Vector3)
      Vector3.new(*tuple(vec.values))
    end

    # Reflect a `Vectorlike` through the plane defined in the `#initialize` method. Return
    # a 3-tuple with the result.
    def *(vectorlike)
      tuple(vectorlike)
    end

    private def tuple(vec)
      {
        vec[0] * @a_11 + vec[1] * @a_12 + vec[2] * @a_13,
        vec[0] * @a_12 + vec[1] * @a_22 + vec[2] * @a_23,
        vec[0] * @a_13 + vec[1] * @a_23 + vec[2] * @a_33,
      }
    end
  end
end
