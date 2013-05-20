require "rubygems"
require "test/unit"

class StringTest < Test::Unit::TestCase

  def test_string_length
    string = "This is my test and I can cry if I want to"
    assert_equal(42, string.length)
  end

  def test_strip_method
    string = "     unstripped     "

    assert_equal('unstripped', string.strip)
  end

  def test_string_comparisons
    string1 = "apples"
    string2 = "apple"
    string3 = "APPLES"

    assert_equal(string1 <=> string2, 1)
    assert_equal(string2 <=> string1, -1)
    assert_equal(string1 <=> string3.downcase, 0)
    assert_equal(string1 <=> string2.length, nil)    
  end

  def test_concat_method
    string = "my string"
    string.concat(" with more string")

    assert_equal string, "my string with more string"
    assert_not_equal string, "my string"
  end

  def test_replace_method
    string = "soup"
    string.replace("beans")

    assert_equal string, "beans"
    assert_not_equal string, "soup"
  end

  def test_element_reference
    string = " this STRING "

    assert_equal string["this"], "this"
    assert_not_equal string[0], "t"
    assert_equal string[-4, 2], "IN"   
  end

end
