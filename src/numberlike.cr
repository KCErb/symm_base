module SymmBase
  # See also `Vectorlike`. A "numberlike" object is one that
  # can perform arithmetic with itself and numbers, except for division,
  # division by self may not be so easily defined.
  #
  # Thanks to the symmetries in arithmetic, this just boils down to defining
  # 5 operations, negation, addition and multiplication, 3 if self and Num can be treated
  # the same.
  abstract struct Numberlike
    alias Num = (Int32 | Float64)

    abstract def -
    abstract def +(other : self)
    abstract def +(other : Num)
    abstract def *(other : self)
    abstract def *(other : Num)

    # We can define minus in terms of plus and negative so we do
    def -(other : self | Num)
      self + (-other)
    end

    # We can define scalar division since 1/number is well-defined
    def /(other : Num)
      self * (1/other)
    end

    # support giving a combined definition by creating a default combined
    # implementation. A little ugly but the best I seem to be able to do atm
    # https://stackoverflow.com/questions/56074831/crystal-how-to-implement-multiple-abstract-methods-with-one-method-in-child/56077092
    def +(other : self | Num)
      other.is_a?(Num) ? self + other : self + other
    end

    def *(other : self | Num)
      other.is_a?(Num) ? self * other : self * other
    end
  end
end

# make operations symmetric, i.e. we can do both
# numberlike * number and number * numberlike
struct Number
  def *(n : SymmBase::Numberlike)
    n * self
  end

  def +(n : SymmBase::Numberlike)
    n + self
  end

  def -(n : SymmBase::Numberlike)
    (-n) + self
  end
end
