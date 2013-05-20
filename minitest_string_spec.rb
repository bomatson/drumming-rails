require "rubygems"
require "minitest/autorun"

class String
  
  def my_test
    "This is my test and I can cry if I want to"
  end

  def unstripped
    "       unstripped      "
  end

  def soup
    "soup"
  end

end


class TestString < Minitest::Test
  def setup
    @string = String.new
    @unstripped = "     unstripped     "
  end

  def test_string_length
    assert_equal 42, @string.my_test.length
  end

  def test_strip_method
    assert_equal "unstripped", @unstripped.strip
  end

  def test_string_comparison
    assert_equal "unstripped" <=> @unstripped.strip, 0
    assert_equal "unstrippede" <=> @unstripped.strip, 1
    assert_equal "unstrip" <=> @unstripped.strip, -1
    assert_equal @string.my_test.length <=> @unstripped.strip, nil
  end

  def test_concat_method
    string = "my string"
    string.concat(" with more string")

    assert_equal string, "my string with more string"
  end

  def test_replace_method
    assert_equal @string.soup, "soup" 
    refute_equal @string.soup.replace("beans"), "soup"
    assert_equal @string.soup.replace("beans"), "beans"

  end

  def test_element_reference
    assert_equal @string.soup[1], "o"
    assert_equal @string.soup[0..2], "sou"
    refute_equal @unstripped[0], "u"
  end
end


#refactor to make instance variables work