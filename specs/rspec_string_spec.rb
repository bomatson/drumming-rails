require "rubygems"
require "rspec"

describe 'String Test' do

  let(:string) {"This is my test"}
  let(:second_string) {"      unstripped      "}
  let(:lowercase_string) {"lowercase"}
  let(:carriage) {"heyo\n"}

  it 'should match on string length' do
    string.length.should eq(15)
  end

  it 'should respond to the strip method' do
    second_string.strip.should eq("unstripped")
  end

  it 'should use string comparisons with single char difference' do
    ("unstrip" <=> "unstripped").should eq(-1)
    ("unstripped" <=> "unstripp").should eq(1)
  end

  it 'should use string comparisons with no char difference' do
    (string <=> "This is my test").should eq(0)
  end

  it 'will return nil if comparing strings to integers' do
    (second_string <=> 5).should be_nil
  end

  it 'should append the string with concat method' do
    string.concat(", my friend").should eq("This is my test, my friend")
  end

  it 'will append the string with arrow concat method' do
    (string << ", my ally").should eq("This is my test, my ally")
  end

  it 'will append a char based on characters id' do
    string.concat(33).should eq("This is my test!")
  end

  it 'should replace the origin string with a new string' do
    string.replace("beans").should eq("beans")
  end

  it 'should recognize an element reference with an index' do
    string[0].should eq("T") 
  end

  it 'should find an element reference with a range' do
    string[0..4].should eq("This ") 
  end

  it 'should find an element reference with a string' do
    string['test'].should eq("test") 
  end

  it 'should properly use the capitalize method' do
    string.capitalize.should eq(string)
  end

  it 'should return nil on bang if element is capitalized' do
    string.capitalize!.should be_nil
  end

  it 'should return capitalized string with bang' do
    lowercase_string.capitalize!.should eq("Lowercase")
  end

  it 'should return string if no change is made with chomp' do
    string.chomp.should eq(string)
  end

  it 'should use chomp properly' do
    carriage.chomp.should eq("heyo")
  end

  it 'should return nil if no change is made with bang chomp' do
    string.chomp!.should be_nil
  end

  it 'will clear the string with the clear method' do
    string.clear.should be_empty
  end

  it 'will delete specified parts of the string with the delete method' do
    second_string.delete("un ").should eq("stripped")
    #delete will remove all instances of the char, including spaces
  end

  it 'will downcase the string' do
    string.downcase.should eq("this is my test")
  end

  it 'will return nil if nothing happens for bang downcase' do
    lowercase_string.downcase!.should be_nil
  end

  it 'will insert the string using the position argument' do
    string.insert(-1, " and that's that").should eq("This is my test and that's that")
  end

  it 'will return an enumerator & array with the lines method' do
    carriage.lines.kind_of? Enumerable
    carriage.lines.kind_of? Array
  end

  it 'will properly use the lines method' do
    carriage.lines.should eq(["heyo\n"])
  end

  it 'will gsub using basic pattern replacement' do
    string.gsub(/[aeiou]/, '[VOWEL]').should eq("Th[VOWEL]s [VOWEL]s my t[VOWEL]st")
  end

  it 'will gsub using hash pattern replacement' do
    string.gsub(/[ie]/, 'i' => '*').should eq("Th*s *s my tst")
  end

  it 'will gsub using hash pattern replacement with an integer' do
    string.gsub(/[ie]/, 'i' => '1', 'e' => 5).should eq("Th1s 1s my t5st")
  end

  it 'will partition the string' do
    string.partition("my").should eq(["This is ", "my", " test"])
  end
  
  it 'will partition the string with regex' do
    string.partition(/my/).should eq(["This is ", "my", " test"])
  end

  it 'will prepend the string with another string' do
    "face".prepend("Gary ").should eq("Gary face")
  end

  it 'will reverse the string' do
    "string".reverse.should eq("gnirts")
  end

  it 'will scan the string by words' do
    "string here".scan(/\w+/).should eq(["string", "here"])
  end

  it 'will scan the string in triple char regex' do
    "string here".scan(/.../).should eq(["str","ing"," he"])
  end

  it 'will split the string by spaces default' do
    " string here".split.should eq(["string", "here"])
  end

  it 'will split the string by each char' do
    "string here".split(//).should eq(["s", "t", "r", "i", "n", "g", " ", "h", "e", "r", "e"])
  end

  it 'will split the string with a char pattern' do
    "string:here".split(':').should  eq(["string", "here"])
  end

  it 'will split the string with a regex pattern' do
    "string here".split(/w/).should eq(["string here"])
  end

  it 'will remove dupes next to each other with squeeze' do
    "strinng   herre".squeeze.should eq("string here")
  end

  it 'will removes dupes when specifying the character' do
    "strinng   herre".squeeze(" ").should eq("strinng herre")
  end

  it 'will removes dupes when specifying the range' do
    "strinng herree".squeeze("m-z").should eq("string heree")
  end

  it 'will evaluate start_with using single parameter' do
    "stringy".start_with?("string").should be_true
  end

  it 'will evaluate start_with using multiple parameters' do
    "stringy".start_with?("string", "other").should be_true
  end

  it 'will evaluate start_with using false multiple parameters' do
    "stringy".start_with?("random", "other").should be_false
  end

  it 'will swapcase with all lowercase' do
    "string".swapcase.should eq("STRING")
  end

  it 'will swapcase with all uppercase' do
    "STRING".swapcase.should eq("string")
  end

  it 'will swapcase with a mix of cases' do
    "StRiNg".swapcase.should eq("sTrInG")
  end

  it 'will use to_i with a number string' do
    "1234".to_i.should eq(1234)
  end

  it 'will use to_i with a mixed string' do
    "99 bottles of beer".to_i.should eq(99)
  end

  it 'will use to_i with a word string' do
    "words".to_i.should be_zero
  end

  it 'will use to_sym to change klass' do
    "words".to_sym.should be_a(Symbol)
  end

  it 'will use intern to change klass' do
    "words".intern.should be_a(Symbol)
  end

  it 'will use to_sym to evaulate special chars' do
    "@words".to_sym.should eq(:@words)
  end

  it 'will use tr to swap simple characters' do
    "think".tr('th', 'st').should eq('stink')
  end

  it 'will use tr to swap ranges' do
    "think".tr('a-t', 'b').should eq('bbbbb')
  end

  it 'will use tr to swap vowels' do
    "think".tr('aeiou', '*').should eq('th*nk')
  end
end
