require "./spec_helper"

module SymmBase
  describe TestPoint do
    it "is constructed with coordinates" do
      vec = Vector3.new(0, 1, 2)
      point = TestPoint.new(vec)
      point.x.should eq 0
      point.y.should eq 1
      point.z.should eq 2
      point.values.should eq({0, 1, 2})
      point.chirality.should eq true
    end

    it "can have its chirality flipped by #invert" do
      vec = Vector3.new(0, 1, 2)
      point = TestPoint.new(vec)
      point.invert(:chirality)
      point.chirality.should eq false
    end

    it "ignores other #invert args" do
      vec = Vector3.new(0, 1, 2)
      point = TestPoint.new(vec)
      point.invert(:charge)
      point.chirality.should eq true
    end
  end
end
