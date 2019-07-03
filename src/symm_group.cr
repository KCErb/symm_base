require "./isometry"

module SymmBase
  # Provides an abstract parent for any class that needs to work with
  # a `Set` of `Isometry`s.
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

    # Implementing class must define the inverse isometry of each isometry
    # in the group.
    abstract def inverse(isometry : Isometry) : Isometry

    # Implementing class must define the group operator which combines two isometries
    # and produces a third.
    abstract def product(isometry1 : Isometry, isometry2 : Isometry) : Isometry

    # If given an array of `Isometry`, we apply the  `#product` in left-to-right order.
    def product(arr : Array(Isometry))
      arr.reverse.reduce do |acc, iso|
        product(iso, acc)
      end
    end
  end
end
