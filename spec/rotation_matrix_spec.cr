require "./spec_helper"

module SymmBase
  describe RotationMatrix do
    it "rotates about an axis by an angle" do
      axis = Vector3.new(0, 1, 1)
      matrix = RotationMatrix.new(axis, Math::PI)
      vec = Vector3.new(0, 0, 1)
      (matrix * vec).should eq Vector3.new(0, 1, 0)
    end
  end
end
