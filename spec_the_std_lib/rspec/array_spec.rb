require "rubygems"
require "rspec"

describe 'Array Test' do

  let(:arr){ [1,2,3,4]}
  let(:nilled) { [1, nil, 2, nil] }
  let(:dupes) { [1,2,2,1] }
  let(:gotchya) { Array.new(2, Hash.new)}

  it 'should allow literal construction of an array' do
    [1,2,3].should be_kind_of(Array)
  end

  it 'should allow construction of an array with many types of objects' do
    [1,"string",3.14].should be_kind_of(Array)
  end

  it 'should allow construction of an array with object notation' do
    Array.new.should eq([])
  end

  it 'should allow new with size parameters' do
    Array.new(2).should eq([nil, nil])
  end

  it 'will pass block to an array' do
    Array.new(2) {Hash.new}.should eq([{},{}])
  end

  it 'will create an array directly using Kernel' do
    Array({key: 'value'}).should eq([[:key, "value"]])
  end

  it 'will access an element in the array with single arg' do 
    arr[2].should eq(3)
  end

  it 'will access an element in the array with start and length args' do 
    arr[0,4].should eq([1,2,3,4])
  end

  it 'will access an element in the array with a range' do 
    arr[0..4].should eq([1,2,3,4])
  end

  it 'will access the first element of the array' do
    arr.first.should be(1)
  end

  it 'will access the last element of the array' do
    arr.last.should be(4)
  end

  it 'will use take to grab the first n elements' do
    arr.take(2).should eq([1,2])
  end

  it 'will use drop to grab the last n elements' do
    expect(arr.drop(2)).to eq([3,4])
  end

  it 'will use include to check if an element is in the array' do
    arr.include?(1).should be_true
  end

  it 'will use empty to check if an array is empty' do
    arr.empty?.should be_false
  end

  it 'will use the push method to insert an integer into an array' do
    arr.push(5).should eq([1,2,3,4,5])
  end

  it 'will use the push method to insert a string into an array' do
    arr.push("bobby").should eq([1,2,3,4,"bobby"])
  end

  it 'will use the push method to insert a symbol into an array' do
    arr.push(:bob).should eq([1,2,3,4,:bob])
  end

  it 'will use the push method to insert an array into an array' do
    arr.push(["feather", "string"]).should eq([1,2,3,4,["feather", "string"]])
  end

  it 'will use the push method to insert a hash into an array' do
    arr.push({}).should eq([1,2,3,4,{}])
  end

  it 'will use the arrows to insert an integer into an array' do
    (arr << 6).should eq([1,2,3,4,6])
  end

  it 'will use unshift to add an element at the beginning of an array' do
    arr.unshift(0).should eq([0,1,2,3,4 ])
  end

  it 'will use unshift to add an element at the beginning of an array' do
    arr.unshift(0).should eq([0,1,2,3,4 ])
  end

  it 'will use insert to add an element at any position in an array' do
    arr.insert(3, "booga").should eq([1,2,3, "booga",4 ])
  end

  it 'will use insert to add multiple elements at any position in an array' do
    arr.insert(1, "booga", "wooga").should eq([1, "booga", "wooga", 2, 3, 4])
  end

  it 'will use pop to grab last element of an array' do
    arr.pop.should eq(4)
  end

  it 'will change the array to not have the last element with pop' do
    arr.pop
    arr.should eq([1,2,3])
  end

  it 'will retrieve the first element of an array with shift' do
    arr.shift.should eq(1)
  end

  it 'will remove the first element of an array with shift' do
    arr.shift
    arr.should eq([2,3,4])
  end

  it 'will delete_at a certain index' do
    arr.delete_at(0).should eq(1)
  end

  it 'will delete_at a certain index and modify the array' do
    arr.delete_at(0)
    arr.should eq([2,3,4])
  end

  it 'will retrieve an object with delete' do
    arr.delete(1).should eq(1)
  end

  it 'will delete an object from the array' do
    arr.delete(1)
    arr.should eq([2,3,4])
  end

  it 'will return nil if the object is not in the array' do
    arr.delete("barry").should be_nil
  end

  it 'will remove nil values with compact' do
    nilled.compact.should eq([1,2])
  end

  it 'will remove nil values with compact but array remains unchanged' do
    nilled.compact
    nilled.should eq([1, nil, 2, nil])
  end


  it 'will remove nil values with compact and change array with bang' do
    nilled.compact!
    nilled.should eq([1,2])
  end

  it 'will remove dupes with uniq' do
    dupes.uniq.should eq([1,2])
  end

  it 'will remove dupes with uniq but leave array unchanged' do
    dupes.uniq
    dupes.should eq([1,2,2,1])
  end

  it 'will remove dupes with uniq and destruct the array with bang' do
    dupes.uniq!
    dupes.should eq([1,2])
  end

  it 'will use each to perform an operation on each elem of the array' do
    arr.each {|a| a.should eq(a) }
  end

  it 'will use each without changing the element of the array' do
    (arr.each {|a| a*2 }).should eq([1,2,3,4])
  end
  
  it 'will use reverse_each without changing the element of the array' do
    (arr.reverse_each {|a| a*2 }).should eq([1,2,3,4])
  end

  it 'will use reverse_each to perform an operation starting from the last elem of the array' do
    mod = []
    arr.reverse_each {|a| mod << a*2 }
    mod.should eq([8,6,4,2])
  end

  it 'will use map to create a new array' do
    arr.map {|a| a }.should_not be(arr)
  end

  it 'will use map to create a new array with each elem modified' do
    arr.map {|a| a*2 }.should eq([2,4,6,8])
  end

  it 'will use selection with an array' do
    arr.select {|a| a < 2 }.should eq([1])
  end

  it 'will use rejection with an array' do
    arr.reject {|a| a < 2 }.should eq([2,3,4])
  end

  it 'will use drop_while with an array' do
    arr.drop_while {|a| a < 2 }.should eq([2,3,4])
  end

  it 'will be non-destructive using selection with an array' do
    arr.select {|a| a < 2 }
    arr.should be(arr)
  end

  it 'will be non-destructive using rejection with an array' do
    arr.reject {|a| a < 2 }
    arr.should be(arr)
  end

  it 'will use delete_if to delete parts of an array' do
    arr.delete_if {|a| a < 2 }.should eq([2,3,4])
  end

  it 'will be destructive using delete_if with an array' do
    arr.delete_if {|a| a < 2 }
    arr.should eq([2,3,4])
  end

  it 'will use keep_if to retain parts of an array' do
    arr.keep_if {|a| a < 2 }.should eq([1])
  end
  
  it 'will be destructive using keep_if with an array' do
    arr.keep_if {|a| a < 2 }
    arr.should eq([1])
  end

  it 'will use brackets to create an empty array' do
    [].should be_kind_of(Array)
  end

  it 'will use brackets to implicitly create an array with objects' do
    ["bobby", 2].should eq(["bobby", 2])
  end

  it 'will use brackets to pass in args and create an array with objects' do
    Array.[]("bobby", 2).should eq(["bobby", 2])
  end

  it 'will create a copy of the array if it passed in with new' do
    second_arr = Array.new(arr)
    second_arr.should_not equal(arr)
  end

  it 'will use the second parameter as the object for ALL array elements' do
    gotchya[0]["bobs"] = 'matson'
    gotchya.should eq([{"bobs"=> "matson"},{"bobs"=> "matson"} ])
    #since all the array elements store the same hash, changing on affects them all
  end

  it 'will use try_convert to turn object into an array' do
    Array.try_convert([1]).should eq([1])
  end

  it 'will use try_convert to return nil if object cannot be converted' do
    Array.try_convert("gary").should be_nil
    #whats the point of this?
  end

  it 'will use & to return an array with common elements from two arrays' do
    (arr & nilled).should eq([1,2]) 
  end

  it 'will use & to return an array without any duplication' do
    (arr & dupes).should eq([1,2]) 
    #cool!
  end

  it 'will use * with integer to concatenate int copies of self' do
    (arr * 2).should eq([1,2,3,4,1,2,3,4])
  end

  it 'will use * with string to create a new string, equivalent to join' do
    (arr * ":").should eq("1:2:3:4")
  end

  it 'will use + to concatenate both arrays' do
    (arr + nilled).should eq([1,2,3,4,1, nil, 2, nil])
  end

  it 'will use - to remove elements that appear in second array' do
    (arr - nilled).should eq([3,4])
  end

  it 'will use - to remove duplicate elements' do
    (dupes - arr).should eq([])
  end

  it 'will use << to add objects to an array' do
    (arr << "robert").should eq([1,2,3,4, "robert"])
  end

  it 'will use << to chain multiple objects to an array' do
    (arr << "robert" << 34 << ['whoa!', 'larry!']).should eq([1,2,3,4,"robert", 34,['whoa!','larry!']])
  end

  it 'will use << to add objects to an array' do
    (arr << "robert").should eq([1,2,3,4, "robert"])
  end

  it 'will use rocket comparison to return +1 if the array is greater than other' do
    (arr <=> dupes).should eq(1)
    #values of each element in array are evaluated
  end

  it 'will use rocket comparison to return -1 if the array is less than other' do
    (dupes <=> arr).should eq(-1)
  end

  it 'will use rocket comparison to return nil if uncomparable' do
    (arr <=> gotchya).should be_nil
  end

  it 'will use length with rocket comparison to determine which is greater' do
    (arr <=> [1,2]).should eq(1)
  end

  it 'will use equality operator and be true if each element is equal' do
    (arr == arr).should be_true
  end

  it 'will use equality operator and be false if the length is unequal' do
    (arr == [1,2,3]).should be_false
  end

  it 'will use equality operator and be false if an element is unequal' do
    (arr == [1,2,3, "gary"]).should be_false
  end

  it 'will use element reference with an index' do
    arr[0].should eq(1)
  end

  it 'will use element reference with an index to return nil if no element exists' do
    arr[5].should be_nil
  end

  it 'will use negative element reference with an index' do
    arr[-1].should eq(4)
  end

  it 'will use element reference with an index then length of objects to reference' do
    arr[0,3].should eq([1,2,3])
  end

  it 'will use element reference with a range of indices' do
    arr[0..3].should eq([1,2,3,4])
  end

  it 'will use element reference with an operator to combine elements' do
    (arr[0] + arr[3]).should eq(5)
  end
end

