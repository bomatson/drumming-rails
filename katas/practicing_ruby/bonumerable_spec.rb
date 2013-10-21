require_relative 'bonumerable'
require_relative 'bonumerator'

class SortedList
  include Bonumerable

  def initialize
    @data = []
  end

  def <<(new_elem)
    @data << new_elem
    @data.sort!

    self
  end

  def each
    if block_given?
      @data.each { |e| yield(e) }
    else
      Bonumerator.new(self, :each)
    end
  end
end

require 'minitest/autorun'

describe 'Bonumerable' do
  before do
    @list = SortedList.new

    @list << 2 << 28 <<  3 << 93
  end

  it 'supports map' do
    @list.map { |x| x + 1 }.must_equal([3,4,29,94])
  end

  it 'supports sort_by' do
    @list.sort_by { |x| x.to_s }.must_equal([2, 28, 3, 93])
  end

  it 'supports select' do
    @list.select { |x| x.even? }.must_equal([2,28])
  end

  describe '#reduce' do

    it "performs a vanilla reduce" do
      @list.reduce { |initial, new| initial + new }.must_equal(126)
    end

    it "accepts method names" do
      @list.reduce(:+).must_equal(126)
    end

    it "accepts an additional argument" do
      @list.reduce(-10) { |initial, new| initial + new }.must_equal(116)
    end
  end
end

describe 'Bonumerator' do
  before do
    @list = SortedList.new

    @list << 2 << 28 << 3 << 93
  end

  it 'supports next' do
    enum = @list.each

    enum.next.must_equal(2)
    enum.next.must_equal(3)
    enum.next.must_equal(28)
    enum.next.must_equal(93)

    assert_raises(StopIteration) { enum.next }
  end

  it 'supports rewind' do
    enum = @list.each

    3.times { enum.next }
    enum.rewind

    2.times { enum.next }
    enum.next.must_equal(28)
  end

  it 'supports with_index' do
    enum = @list.map
    expected = ['0. 2', '1. 3', '2. 28', '3. 93']

    enum.with_index {|i, e| "#{i}. #{e}"}.must_equal(expected)
  end
end

