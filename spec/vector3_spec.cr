require "./spec_helper"

module SymmBase
  describe Vector3 do
    # my methods my tests
    it "distinguishes == from close_to?" do
      v1 = Vector3.new(1.0, 0.0, 0.0)
      # https://github.com/crystal-lang/crystal/issues/3103
      v2 = Vector3.new(1.0000000001, 0.0, 0.0)
      v1.should_not eq v2
      v1.close_to?(v2).should be_true
    end

    it "can tell if something is nearly zero" do
      v1 = Vector3.new(1.0, 0.0, 0.0)
      # this number should have more zeros but rounding is broken
      # https://github.com/crystal-lang/crystal/issues/3103
      v2 = Vector3.new(1.0000000001, 0.0, 0.0)
      (v2 - v1).nearly_zero?.should be_true
    end

    it "can be cloned" do
      v1 = Vector3.new(1.0, 0.0, 0.0)
      v2 = v1.clone
      v2.x = 3.0
      v1.x.should eq 1.0
    end

    # original lib's methods, original tests (more or less)
    # https://github.com/unn4m3d/crystaledge/blob/master/spec/crystaledge_spec.cr
    it "works" do
      vzero = Vector3.new(0.0, 0.0, 0.0)
      vec2 = Vector3.new(3.0, 4.0, 0.0)
      (vzero == vec2).should eq(false)
      (vzero + vec2).should eq(vec2)
      (vzero - vec2).values.should eq({-3.0, -4.0, -0.0})
      (vzero - vec2).should eq(-vec2)

      vec3 = Vector3.new(0.0, 3.0, 4.0)
      vec4 = Vector3.new(3.0, 0.0, 4.0)
      m = 5.0
      vec2.magnitude.should eq(m)
      vec3.magnitude.should eq(m)
      vec4.magnitude.should eq(m)
      (vec4*2.0).magnitude.should eq(10)

      vec4.x = 42.0
      vec4.should_not eq(vzero)
      vec4.should eq(Vector3.new(42.0, 0.0, 4.0))
      vec4.normalized.magnitude.should eq(1.0)
    end
  end
end
