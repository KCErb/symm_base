# Generalize the notion of what an isometery's transformation matrix can act on.
# It just needs to have 3 elements that we can get at by `thing[0]`, `thing[1]`, and ``thing[2]`
# and return for each something that we can define addition, subtraction, multiplication and division for
# (see `Numberlike`).
private alias Combined = Float64 | Int32 | Numberlike
alias Vectorlike = NumericArray | Array(Combined) | Tuple(Combined, Combined, Combined)

abstract struct NumericArray
  abstract def [](index : Int32) : Numberlike
end
