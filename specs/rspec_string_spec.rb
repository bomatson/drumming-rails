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

    "unstripped".should_not eq(second_string)
    
  end

  it 'should use string comparisons properly' do
    
    (string <=> "This is my test").should eq(0)
    (second_string <=> "unstrippeded").should eq(-1)
    (second_string.strip <=> "unstripp").should eq(1)

    (second_string <=> string.length).should be_nil

  end

  it 'should append the string with concat method' do
    
    string.concat(", my friend").should eq("This is my test, my friend")

    string.should_not eq("This is my test")
    
  end

  it 'should replace the origin string with a new string' do

    string.replace("beans").should eq("beans")
    string.should_not eq("This is my test")
    string.should eq("beans")
  end

  it 'should recognize an element reference' do
    string[0].should eq("T")
    string[0].should_not eq("t")   
    string[0..4].should eq("This ") 
  end

  it 'should properly use the capitalize method' do
    string.capitalize.should eq(string)

    lowercase_string.capitalize!.should eq("Lowercase")
    lowercase_string.capitalize!.should be_nil
    #with the bang version of capitalize, the capitalize method returns 
    #nil if the operation has already been performed
  end

  it 'should chomp off a carriage return and use chomp! properly' do
    string.chomp.should eq(string)
    string.chomp!.should eq(nil)
    carriage.chomp.should eq("heyo")

  end
end
