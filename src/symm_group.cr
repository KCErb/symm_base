require "./isometry"

module SymmBase
  # A symmetry group is a `Set` of `Isometry`s.
  abstract class SymmGroup
    getter name : String
    getter isometries = Set(Isometry).new

    # Associates isometries into a group with name `name`.
    def initialize(@name, isometries_arr)
      isometries_arr.each { |iso| @isometries << iso }
    end

    # Returns the size of the isometries array.
    def order
      isometries.size
    end
  end
end
