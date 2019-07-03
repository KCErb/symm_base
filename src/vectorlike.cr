module SymmBase
  # A 3-tuple of `Float64`, `Int32` or `SymmBase::Numberlike`
  alias Vectorlike = Tuple(Num | Numberlike, Num | Numberlike, Num | Numberlike)
end
