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

  def test_squeeze_to_remove_dupes
    assert_equal "strinng    herre".squeeze, "string here"
  end

  def test_squeeze_to_remove_dupes_with_specific_char
    assert_equal "strinng    herre".squeeze(" "), "strinng herre"
  end

  def test_squeeze_to_remove_dupes_with_range
    assert_equal "strinng herree".squeeze("m-z"), "string heree"
  end

  def test_start_with_single_parameter
    assert_equal "stringy".start_with?("string"), true
  end

  def test_start_with_multiple_parameters
    assert_equal "stringy".start_with?("other", "string"), true
  end

  def test_start_with_false_multiple_parameters
    refute_equal "stringy".start_with?("other", "random"), true
  end

  def test_swapcase_to_uppercase
    assert_equal "string".swapcase, "STRING"
  end

  def test_swapcase_to_lowercase
    assert_equal "STRING".swapcase, "string"
  end

  def test_swapcase_mix_cases
    assert_equal "sTrInG".swapcase, "StRiNg"
  end

  def test_to_i_from_number_string
    assert_equal "124".to_i, 124
  end

  def test_to_i_from_mixed_string
    assert_equal "99 bottles of beer".to_i, 99
  end

  def test_to_i_from_word_string
    assert_equal "words".to_i, 0
  end

  def test_to_sym_reg_string
    assert_equal "string".to_sym, :string 
  end

  def test_intern_returns_symbol
    assert_equal "string".intern, :string 
  end

  def test_special_char_to_sym
    assert_equal "@variable".to_sym, :@variable
  end

  def test_tr_method_simple_trade
    assert_equal "think".tr('th', 'st'), "stink"
  end

  def test_tr_method_range
    assert_equal "think".tr('a-t', 'b'), 'bbbbb'
  end

  def test_tr_method_vowels
    assert_equal "think".tr('aeiou', '*'), 'th*nk'
  end

  def test_upto_successive_values
    assert_equal "a".upto("c").to_a, ["a", "b", "c"]
  end

  def test_upto_successive_integers
    assert_equal "1".upto("3").to_a, ["1", "2", "3"]
  end

  def test_upto_is_enumerator
    assert_kind_of Enumerator, "a".upto("c")
  end
end
