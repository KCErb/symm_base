module SymmBase
  # Reflect a point through a plane which is normal to `axis` and contains the origin.

  class ReflectionMatrix
    # pre-computed matrix elements
    @a_11 : Float64
    @a_22 : Float64
    @a_33 : Float64
    @a_12 : Float64
    @a_13 : Float64
    @a_23 : Float64

    # creates a reflection
    def initialize(vec : Vector3)
      x, y, z = vec.normalized.values
      @a_11 = 1 - 2*x**2
      @a_22 = 1 - 2*y**2
      @a_33 = 1 - 2*z**2
      @a_12 = -2*x*y
      @a_13 = -2*x*z
      @a_23 = -2*y*z
    end

    # return Vector3 if Vector3 passed in
    def *(vec : Vector3)
      Vector3.new(*tuple(vec.values))
    end

    # pass back tuple if something else is passed in, that something else
    # just needs to understand * and + and have three elements accessible by []
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
