require "rubygems"
require "minitest/autorun"

class TestArray < Minitest::Test

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

  def test_passing_block_to_array
    assert_equal Array.new(2) {Hash.new}, [{},{}]
  end

  def test_array_creation_directly
    assert_equal Array({key: 'value'}), [[:key, "value"]]
  end

  def test_access_element_with_single_arg
    arr = [1,2,3,4] 
    assert_equal arr[2], 3
  end

  def test_access_element_with_start_and_length
    arr = [1,2,3,4] 
    assert_equal arr[0,3], [1,2,3] 
  end

  def test_access_element_with_a_range
    arr = [1,2,3,4] 
    assert_equal arr[0..3], [1,2,3,4] 
  end

  def test_first_method_on_array
    assert_equal [1,2,3,4].first, 1
  end

  def test_last_method_on_array
    assert_equal [1,2,3,4].last, 4
  end

  def test_take_method_on_array
    assert_equal [1,2,3,4].take(2), [1,2]
  end

  def test_drop_method_on_array
    assert_equal [1,2,3,4].drop(2), [3,4]
  end
end
