require "rubygems"
require "minitest/autorun"

class TestString < Minitest::Test
  def setup
    @test = "This is my test and I can cry if I want to"
    @unstripped = "     unstripped     "
    @soup = "soup"
  end

  def test_string_length
    assert_equal 42, @test.length
  end

  def test_strip_method
    assert_equal "unstripped", @unstripped.strip
  end

  def test_string_comparison
    assert_equal "unstripped" <=> @unstripped.strip, 0
    assert_equal "unstrippede" <=> @unstripped.strip, 1
    assert_equal "unstrip" <=> @unstripped.strip, -1
    assert_equal @test.length <=> @unstripped.strip, nil

  end

  def test_concat_method
    string = "my string"
    string.concat(" with more string")

    assert_equal string, "my string with more string"

    string << " and more string"

    assert_equal string, "my string with more string and more string"
    refute_equal string, "my string with more string"

  end

  def test_replace_method
    assert_equal @soup, "soup" 
    refute_equal @soup.replace("beans"), "soup"
    assert_equal @soup.replace("beans"), "beans"

  end

  def test_element_reference
    assert_equal @soup[1], "o"
    assert_equal @soup[0..2], "sou"
    refute_equal @soup[0], "u"
  end

  def test_capitalize_method
    assert_equal @soup.capitalize , "Soup"
    refute_equal @soup.capitalize, @soup

    assert_equal @unstripped.capitalize, @unstripped
    #since the first char is a space, there is no char to capitalize
  end

  def test_chomp_method
    refute_equal "heyo\n".chomp, "heyo\n"
    assert_equal "heyo\n".chomp, "heyo"
    assert_equal @soup.chomp("p"), "sou"
    assert_equal @test.chomp!, nil
    assert_equal @test.chomp, "This is my test and I can cry if I want to"

  end

  def test_clear_method
    assert_equal @soup.clear, ""
    refute_equal @soup.clear, "soup"
    assert_empty @soup
  end
end
