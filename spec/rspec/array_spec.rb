require "rubygems"
require "rspec"

describe 'Array Test' do

  let(:arr){ [1,2,3,4]}

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
end
