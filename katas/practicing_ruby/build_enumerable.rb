module Bonumerable

  def map
    result = []
    each { |i| result << yield(i) }
    result
  end

  def select
    result = []
    each { |i| result << i if yield(i) }
    result
  end
end
