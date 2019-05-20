require "./spec_helper"

module SymmBase
  describe Numberlike do
    four = TestNumberlike.new(4)
    three = TestNumberlike.new(3)
    it "should support basic arithmetic with num" do
      (-four).should eq TestNumberlike.new(-4)
      (four + 2).should eq TestNumberlike.new(6)
      (four - 2).should eq TestNumberlike.new(2)
      (four * 2).should eq TestNumberlike.new(8)
      (four / 2.0).should eq TestNumberlike.new(2)
    end
    it "should support reverse basic arithmetic with num (no div)" do
      (2 + four).should eq TestNumberlike.new(6)
      (2 - four).should eq TestNumberlike.new(-2)
      (2 * four).should eq TestNumberlike.new(8)
    end
    it "should support reverse arithmetic with self (no div)" do
      (three + four).should eq TestNumberlike.new(7)
      (three - four).should eq TestNumberlike.new(-1)
      (three * four).should eq TestNumberlike.new(12)
    end
  end
end
