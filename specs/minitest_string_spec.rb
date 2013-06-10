require "rubygems"
require "minitest/autorun"

class TestString < Minitest::Test

  def test_string_length
    assert_equal "This is my test and I can cry if I want to".length, 42
  end

  def test_strip_method
    assert_equal "     unstripped     ".strip, "unstripped"
  end

  def test_string_comparisons_with_single_char_difference
    assert_equal "unstrippede" <=> "unstripped", 1
    assert_equal "unstrip" <=> "unstripped", -1
  end

  def test_string_comparison_with_spaces
    assert_equal "spaces" <=> "     spaces     ", 1
    #returns 1 instead of -1 because space is counted as earlier in the ABCs
  end

  def string_comparisons_return_nil_against_integer
    assert_equal 4 <=> "some string", nil
  end

  def test_concat_method
    assert_equal "my string".concat(" with more string"), "my string with more string"
  end

  def test_arrow_concat_method
    assert_equal "string" << " and more string", "string and more string"
  end

  def test_replace_method
    assert_equal "soup".replace("beans"), "beans"
  end

  def test_element_reference_with_index
    soup = "soup"
    assert_equal soup[1], "o"
    assert_equal soup[0..2], "sou"
  end

  def test_capitalize_method
    assert_equal "soup".capitalize , "Soup"
  end

  def test_capitalize_against_spaces
    assert_equal " space".capitalize, " space"
  end

  def test_chomp_method
    assert_equal "heyo\n".chomp, "heyo"
  end

  def test_chomp_method_with_argument
    assert_equal "soup".chomp("p"), "sou"
  end

  def test_chomp_bang_method
    assert_equal "test".chomp!, nil
  end

  def test_clear_method
    assert_empty "clear me".clear
  end

  def test_delete_method 
    assert_equal "soup".delete("so"), "up"
  end

  def test_downcase_method
    assert_equal "CAPITALIZATION".downcase, "capitalization"
  end

  def test_downcase_with_bang
    assert_equal "soup".downcase!, nil
  end

  def test_insert_method
    assert_equal "soup".insert(0, 'Campbell\'s '), "Campbell's soup"
  end

  def test_lines_method_class
    assert_kind_of Array, "this\n is a new \n thing".lines
  end

  def test_lines_method_usage
    assert_equal "this\n is a new \n thing".lines, ["this\n", " is a new \n", " thing"]
  end

  def test_gsub_pattern_replacement
    assert_equal "string".gsub(/[aeiou]/, '[VOWEL]'), "str[VOWEL]ng"
  end

  def test_gsub_hash_replacement
    assert_equal "string".gsub(/[i]/, 'i' => '*'), "str*ng"
  end

  def test_gsub_hash_replacement_with_integer
    assert_equal "string".gsub(/[i]/, 'i' => 1), "str1ng"
  end
end
