require "./spec_helper"

module SymmBase
  describe RotationMatrix do
    it "rotates about an axis by an angle" do
      axis = Vector3.new(0, 1, 1)
      matrix = RotationMatrix.new(axis, Math::PI)
      vec = Vector3.new(0, 0, 1)
      (matrix * vec).should eq Vector3.new(0, 1, 0)
    end

    it "can be multiplied by another rotation matrix" do
      a = RotationMatrix.new({ {1,2,3}, {4,5,6}, {7,8,9} })
      b = RotationMatrix.new({ {1,4,7}, {2,5,8}, {3,6,9} })
      c = RotationMatrix.new({ {14,32,50}, {32, 77,122}, {50,122,194} })
      (a * b).matrix.should eq c.matrix
    end
  end
end
