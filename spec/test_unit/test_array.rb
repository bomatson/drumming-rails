require "rubygems"
require "test/unit"

class ArrayTest < Test::Unit::TestCase

  def test_literal_array_creation
    assert_kind_of Array, [1,2,3]
  end

  def test_multiple_types_of_objects_stored_in_array
    assert_kind_of Array, [1, 3.14, "string"]
  end

  def test_object_notation
    assert_equal Array.new, []
  end

  def test_object_notation_with_size_parameters
    assert_equal Array.new(2), [nil,nil]
  end

end
