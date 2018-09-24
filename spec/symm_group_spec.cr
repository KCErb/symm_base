require "./spec_helper"

module SymmBase
  describe SymmGroup do
    iso = TestIsometry.new(3)
    comp = TestCompoundIsometry.new
    test_group = TestSymmGroup.new("foo_bar", [iso, comp])

    it "has basic properties" do
      test_group.name.should eq "foo_bar"
      test_group.order.should eq 2
      test_group.isometries.should eq Set{iso, comp}
    end
  end
end
