module SymmBase
  # Just a 3-length tuple of float64, int32 or something else numberlike
  alias Num = Float64 | Int32 | Numberlike
  alias Vectorlike = Tuple(Num, Num, Num)
end
