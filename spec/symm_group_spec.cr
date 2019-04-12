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

    it "can find an inverse" do
      inv = test_group.inverse(iso)
      inv.increment.should eq -3
    end

    it "can take a product of 2 isometries" do
      prod = test_group.product(iso, comp)
      prod.increment.should eq 2
    end

    it "product is order dependent if group is abelian" do
      prod = test_group.product(comp, iso)
      prod.increment.should eq 8
    end

    it "can take a product of an array of isometries" do
      iso2 = TestIsometry.new(2)
      prod = test_group.product([iso, comp, iso2])
      prod.increment.should eq 4

      prod = test_group.product([iso2, iso, comp])
      prod.increment.should eq 0
    end
  end
end
