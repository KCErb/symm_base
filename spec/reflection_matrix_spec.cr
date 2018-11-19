require "./spec_helper"

module SymmBase
  describe ReflectionMatrix do
    matrix = ReflectionMatrix.new(Vector3.new(1, 1, 1))

    it "reflects about an axis" do
      vec = Vector3.new(1, 1, 1)
      reflected_vec = Vector3.new(-1, -1, -1)
      (matrix * vec).close_to?(reflected_vec).should be_true
    end
  end
end
