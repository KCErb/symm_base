module SymmBase
  # See also `Vectorlike`. A "numberlike" object is one that
  # can perform arithmetic with itself and numbers, except for division,
  # since division by `self` may not be so easily defined.
  #
  # Thanks to the symmetries in arithmetic, this just boils down to defining
  # 3 operations: negation, addition and multiplication.
  abstract struct Numberlike
    abstract def -
    abstract def +(other : self)
    abstract def +(other : Num)
    abstract def *(other : self)
    abstract def *(other : Num)

    # Automatically define `- other` based on addition (`#+`) and negation (`#-`)
    def -(other : self | Num)
      self + (-other)
    end

    # Automatically define `/ other` based on multiplication (`#*`) and the fact that `1/Num` is well-defined.
    def /(other : Num)
      self * (1/other)
    end

    # So that child structs can either define `+(self)` and `+(Num)` separately or
    # together, we give the individuals as abstract methods and the combined here
    # as concrete methods.
    #
    # https://stackoverflow.com/questions/56074831/crystal-how-to-implement-multiple-abstract-methods-with-one-method-in-child/56077092
    def +(other : self | Num)
      other.is_a?(Num) ? self + other : self + other
    end

    # So that child structs can either define `*(self)` and `*(Num)` separately or
    # together, we give the individuals as abstract methods and the combined here
    # as concrete methods.
    #
    # https://stackoverflow.com/questions/56074831/crystal-how-to-implement-multiple-abstract-methods-with-one-method-in-child/56077092
    def *(other : self | Num)
      other.is_a?(Num) ? self * other : self * other
    end
  end
end

# Add the `SymmBase::Numberlike` operations to the `Number` class
# so that they are symmetric.
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
