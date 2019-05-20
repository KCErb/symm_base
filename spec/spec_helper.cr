require "spec"
require "../src/symm_base"

module SymmBase
  class TestIsometry
    include Isometry
    getter increment

    def initialize(@increment = 0)
      @kind = :test_isometry
    end

    def transform(vectorlike : Vectorlike, sym_arr = [] of Symbol)
      if sym_arr.includes? :test
        {vectorlike[0], vectorlike[1], vectorlike[2] - @increment}
      else
        {vectorlike[0], vectorlike[1], vectorlike[2] + @increment}
      end
    end

    def transform(point : Point)
      new_coord = point.coordinates
      new_coord.z += @increment
      p_new = point.clone
      p_new.coordinates = new_coord
      p_new
    end
  end

  class TestCompoundIsometry
    include CompoundIsometry
    getter increment = 5

    def initialize
      @kind = :test_compound_isometry
      @isometries = Set(Isometry).new
      @isometries << TestIsometry.new(2)
      @isometries << TestIsometry.new(3)
    end
  end

  struct TestPoint < Point
    getter chirality : Bool

    def initialize(@coordinates)
      @chirality = true
    end

    def ==(other : TestPoint)
      coordinates.round(Float64::DIGITS) == other.coordinates.round(Float64::DIGITS) &&
        @chirality == other.chirality
    end

    def invert(symbol : Symbol)
      if symbol == :chirality
        @chirality = !@chirality
      end
    end

    def_clone
  end

  class TestSymmGroup < SymmGroup
    def inverse(isometry)
      TestIsometry.new(-isometry.increment)
    end

    # non abelian
    def product(iso1, iso2)
      if iso2.increment >= iso1.increment
        TestIsometry.new(iso2.increment - iso1.increment)
      else
        TestIsometry.new(iso2.increment + iso1.increment)
      end
    end
  end

  # just a wrapper to num for the test
  struct TestNumberlike < Numberlike
    getter val : Int32 | Float64

    def initialize(@val); end

    def -
      self.class.new(-val)
    end

    # demonstrate that we support both separated defs (+)
    def +(other : self)
      self.class.new(val + other.val)
    end

    def +(other : Num)
      self.class.new(val + other)
    end

    #  and combined defs (*)
    def *(other : self | Num)
      if other.is_a?(self)
        self.class.new(val * other.val)
      else
        self.class.new(val * other)
      end
    end
  end
end
