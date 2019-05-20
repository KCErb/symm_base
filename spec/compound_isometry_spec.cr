require "./spec_helper"

module SymmBase
  describe CompoundIsometry do
    it "transforms a point based on children's combined rules" do
      comp = TestCompoundIsometry.new
      zero = Vector3.new(0, 0, 0)
      point = TestPoint.new(zero)
      res = comp.transform(point)
      ans_vec = Vector3.new(0, 0, 5)
      ans = TestPoint.new(ans_vec)
      res.should eq ans
    end

    it "transforms a point based on children's combined rules, passes sym onto children" do
      comp = TestCompoundIsometry.new
      zero = {0, 0, 0}
      res = comp.transform(zero, [:test, :fake])
      ans_vec = {0, 0, -5}
      res.should eq ans_vec
    end

    it "it's an isometry" do
      CompoundIsometry.is_a? Isometry
    end
  end
end
