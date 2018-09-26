require "spec"
require "../src/symm_base"

module SymmBase
  class TestIsometry
    include Isometry

    def initialize(@increment = 0)
      @kind = :test_isometry
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
  end
end
