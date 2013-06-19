require "rubygems"
require "test/unit"

class StringTest < Test::Unit::TestCase

  def test_test_length
    assert_equal "This is my test and I can cry if I want to".length, 42
  end

  def test_strip_method
    assert_equal "     unstripped     ".strip, "unstripped"
  end

  def test_string_comparisons_with_single_char_difference
    assert_equal("apples" <=> "apple", 1)
    assert_equal("apple" <=> "apples", -1) 
  end  

  def comparing_string_and_integer_returns_nil
    assert_equal("apples" <=> 5, nil)  
  end

  def test_concat_method
    assert_equal "my test".concat(" with more test"), "my test with more test"
  end

  def test_arrow_concat_method
    assert_equal "my test" << " and even more test", "my test and even more test"
  end

  def test_replace_method
    assert_equal "soup".replace("beans"), "beans"
  end

  def test_element_reference_with_string
    test = " this STRING "
    assert_equal test["this"], "this" 
  end

  def test_element_reference_using_index
    test = " this STRING "
    assert_equal test[-4, 2], "IN"   
  end

  def test_element_reference_counts_spaces
    test = " this STRING "
    assert_not_equal test[0], "t"
  end

  def test_capitalize_method
    assert_equal "lowercase".capitalize, "Lowercase"
  end

  def test_chomp_method
    assert_equal "heyo\n".chomp, "heyo"
    assert_not_equal "heyo\n".chomp, "heyo\n"
  end

  def test_chomp_bang_method
    assert_equal "test".chomp!, nil
  end

  def test_clear_method
    test = "clear me!"
    assert_not_equal test.clear, "clear me!"
    assert_equal test, ""
  end

  def test_delete_method
    assert_equal "delete the e".delete("e"), "dlt th "
  end

  def test_downcase_method_with_all_capitals
    assert_equal "UPPERCASE".downcase, "uppercase"
  end

  def test_downcase_method_with_random_capitals
    assert_equal "kindaCasEd".downcase, "kindacased"
  end

  def test_downcase_bang
    assert_equal "lowercase".downcase!, nil
  end

  def test_insert_method
    assert_equal "Bobby".insert(-3, "bb"), "Bobbbby"
  end

  def test_lines_method_usage
    assert_equal "this\n is a new \n thing".lines, ["this\n", " is a new \n", " thing"]
  end

  def test_lines_method_class
    test = "this\n is a new \n thing"
    assert_kind_of Enumerable, test.lines
    assert_kind_of Array, test.lines
    # these both pass, how???? Can something be an enumerable and an array?
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

  def test_string_partition
    assert_equal "string".partition("t"), ["s", "t", "ring"]
  end

  def test_string_partition_with_regex
    assert_equal "hello".partition(/.l./), ["h", "ell", "o"]
  end

  def prepend_string_on_another_string
    assert_equal "face".prepend("Gary "), "Gary face"
  end

  def test_string_reversal
    assert_equal "string".reverse, "gnirts"
  end

  def test_scan_word_regex
    assert_equal "string here".scan(/\w+/), ["string", "here"]
  end

  def test_scan_group_three_char_regex
    assert_equal "string here".scan(/.../), ["str", "ing", " he"]
  end

  def test_split_method_with_spaces_default
    assert_equal " string here".split, ["string", "here"]
  end

  def test_split_method_with_each_char
    assert_equal "string here".split(//), ["s", "t", "r", "i", "n", "g", " ", "h", "e", "r", "e"]
  end

  def test_split_method_with_char_pattern
    assert_equal "string:here".split(':'), ["string", "here"]
  end

  def test_split_method_with_regex_pattern
    assert_equal "string here".split(/w/), ["string here"]
  end
end
