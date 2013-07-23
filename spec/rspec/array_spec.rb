require "rubygems"
require "rspec"

describe 'Array Test' do

  let(:arr){ [1,2,3,4]}
  let(:nilled) { [1, nil, 2, nil] }
  let(:dupes) { [1,2,2,1] }

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
end
