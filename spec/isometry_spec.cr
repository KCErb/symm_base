require "./spec_helper"

module SymmBase
  describe TestIsometry do
    it "transforms the TestPoint" do
      vec = Vector3.new(0, 0, 0)
      point = TestPoint.new(vec)
      res = TestIsometry.new(3).transform(point)
      ans_vec = Vector3.new(0, 0, 3)
      ans = TestPoint.new(ans_vec)
      res.should eq ans
    end

    it "transforms something that is vectorlike" do
      res = TestIsometry.new(3).transform([0,0,1])
      res.should eq({0, 0, 4})
    end
  end
end
