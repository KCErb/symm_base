module SymmBase
  # Rotate a `Vector3` about an axis by an angle
  class RotationMatrix
    # pre-computed matrix elements
    # :nodoc:
    alias Num = Int32 | Float64
    # :nodoc:
    alias Row = {Num, Num, Num}
    getter matrix : {Row, Row, Row}

    # Creates a rotation
    def initialize(axis, angle)
      @matrix = compute_matrix(axis, angle)
    end

    def initialize(@matrix); end

    # matrix multiplication to create a new rotation from two old ones
    def *(other_rotation : self)
      other = other_rotation.matrix
      new_matrix = {
        {
          @matrix[0][0]*other[0][0] + @matrix[0][1]*other[1][0] + @matrix[0][2]*other[2][0],
          @matrix[0][0]*other[0][1] + @matrix[0][1]*other[1][1] + @matrix[0][2]*other[2][1],
          @matrix[0][0]*other[0][2] + @matrix[0][1]*other[1][2] + @matrix[0][2]*other[2][2],
        },
        {
          @matrix[1][0]*other[0][0] + @matrix[1][1]*other[1][0] + @matrix[1][2]*other[2][0],
          @matrix[1][0]*other[0][1] + @matrix[1][1]*other[1][1] + @matrix[1][2]*other[2][1],
          @matrix[1][0]*other[0][2] + @matrix[1][1]*other[1][2] + @matrix[1][2]*other[2][2],
        },
        {
          @matrix[2][0]*other[0][0] + @matrix[2][1]*other[1][0] + @matrix[2][2]*other[2][0],
          @matrix[2][0]*other[0][1] + @matrix[2][1]*other[1][1] + @matrix[2][2]*other[2][1],
          @matrix[2][0]*other[0][2] + @matrix[2][1]*other[1][2] + @matrix[2][2]*other[2][2],
        },
      }
      self.class.new(new_matrix)
    end

    # Transforms `vec` by rotating it, returns new `Vector3`
    def *(vec : Vector3)
      x, y, z = vec.values
      tuple = {
        x * @matrix[0][0] + y * @matrix[0][1] + z * @matrix[0][2],
        x * @matrix[1][0] + y * @matrix[1][1] + z * @matrix[1][2],
        x * @matrix[2][0] + y * @matrix[2][1] + z * @matrix[2][2],
      }
      Vector3.new(*tuple)
    end

    private def compute_matrix(vec, angle)
      x, y, z = vec.normalized.values
      cth = Math.cos(angle)
      sth = Math.sin(angle)
      om_cth = 1 - cth # one-minus cosine theta

      a_11 = x*x*om_cth + cth
      a_12 = x*y*om_cth - z*sth
      a_13 = x*z*om_cth + y*sth

      a_21 = x*y*om_cth + z*sth
      a_22 = y*y*om_cth + cth
      a_23 = y*z*om_cth - x*sth

      a_31 = x*z*om_cth - y*sth
      a_32 = y*z*om_cth + x*sth
      a_33 = z*z*om_cth + cth

      @matrix = { {a_11, a_12, a_13}, {a_21, a_22, a_23}, {a_31, a_32, a_33} }
    end
  end
end
