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

  def test_include_element_in_array
    assert_equal [1,2,3,4].include?(1), true   
  end

  def test_empty_method_on_array
    assert_equal [1,2,3,4].empty?, false   
  end

  def test_push_method_with_integer
    assert_equal [1,2,3].push(4), [1,2,3,4]
  end

  def test_push_method_with_string
    assert_equal [1,2,3].push("bobby"), [1,2,3,"bobby"]
  end

  def test_push_method_with_symbol
    assert_equal [1,2,3].push(:bob), [1,2,3,:bob]
  end

  def test_push_method_with_array
    assert_equal [1,2,3].push(["robert"]), [1,2,3,["robert"]]
  end

  def test_push_method_with_hash
    assert_equal [1,2,3].push({}), [1,2,3,{}]
  end

  def test_push_method_using_arrows
    assert_equal ([1,2,3] << 4), [1,2,3,4]
  end

  def test_unshift_add_to_beginning_of_array
    assert_equal [1,2,3].unshift(0), [0,1,2,3]
  end

  def test_insert_add_anywhere_in_array
    assert_equal [1,2,3].insert(1, "booga"), [1,"booga",2,3]
  end

  def test_insert_add_multiple_anywhere_in_array
    assert_equal [1,2,3].insert(1, "booga", "wooga"), [1,"booga", "wooga",2,3]
  end
end
