module Bonumerable

  def map
    if block_given?
      [].tap{ |out| each { |e| out << yield(e) } }
    else
      Bonumerator.new(self, :map)
    end
  end

  def sort_by
    map{ |a| [yield(a), a]}.sort.map{ |a| a[1]}
  end

  def select
    [].tap{ |out| each { |i| out << i if yield(i) } }
  end

  def reduce(operation_or_value=nil)
    case operation_or_value
    when Symbol
      return reduce { |s,e| s.send(operation_or_value, e) }
    when nil
      acc = nil
    else
      acc = operation_or_value
    end

    each do |a|
      acc = acc.nil? ? a : yield(acc, a)
    end

    return acc
  end
end
