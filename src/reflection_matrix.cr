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

    # Transforms `vec` by reflecting it, returns new `Vector3`
    def *(vec : Vector3)
      tuple = {
        vec.x * @a_11 + vec.y * @a_12 + vec.z * @a_13,
        vec.x * @a_12 + vec.y * @a_22 + vec.z * @a_23,
        vec.x * @a_13 + vec.y * @a_23 + vec.z * @a_33,
      }
      Vector3.new(*tuple)
    end
  end
end
