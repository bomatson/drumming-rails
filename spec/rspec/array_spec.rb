require "rubygems"
require "rspec"

describe 'Array Test' do

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

end
