module SymmBase
  # Rotate a `Vector3` about an axis by an angle. The rotation matrix here
  # is a conventional right-handed active transformation.
  # https://en.wikipedia.org/wiki/Active_and_passive_transformation.
  class RotationMatrix
    # A matrix is just a 3-tuple of 3-tuples of `SymmBase::Num`s here.
    # So `Symm  Row` is just a placeholder for static typing.
    alias Row = {Num, Num, Num}
    # 3-Tuple of `Row`s which each hold three numbers.
    getter matrix : {Row, Row, Row}

    # Creates a right-handed rotation about the axis defined by the given `Vector3` by
    # angle given by `angle`.
    def initialize(axis : Vector3, angle)
      @matrix = compute_matrix(axis, angle)
    end

    # In truth, this just sets the matrix to anything, so it doesn't have to be a
    # true rotation, but the purpose is so that rotation matrices can be applied.
    def initialize(@matrix); end

    # Matrix multiplication to create a new rotation from two old ones.
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

    # Rotate `Vector3` according to constructor. Return a `Vector3` as well.
    def *(vec : Vector3)
      Vector3.new(*tuple(vec.values))
    end

    # Rotate a `Vectorlike` same as a `Vector3`.
    def *(vectorlike)
      tuple(vectorlike)
    end

    private def tuple(vec)
      x, y, z = {vec[0], vec[1], vec[2]}
      {
        x * @matrix[0][0] + y * @matrix[0][1] + z * @matrix[0][2],
        x * @matrix[1][0] + y * @matrix[1][1] + z * @matrix[1][2],
        x * @matrix[2][0] + y * @matrix[2][1] + z * @matrix[2][2],
      }
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
