require_relative 'bonumerable'

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

  it 'supports reduce' do
    @list.reduce { |initial, new| initial + new }.must_equal(126)
    @list.reduce(-10) { |initial, new| initial + new }.must_equal(116)
    @list.reduce(:+).must_equal(126)
  end
end

