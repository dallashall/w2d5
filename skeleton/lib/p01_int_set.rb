class MaxIntSet
  def initialize(max)
    @store = Array.new(max) {[]}
    @max = max
  end

  def insert(num)
    is_valid?(num)
    @store[mod_it(num)] << num
  end

  def remove(num)
    is_valid?(num)
    @store[mod_it(num)].delete(num)
  end

  def include?(num)
    @store[mod_it(num)].include?(num)
  end

  private

  def is_valid?(num)
    raise "Out of bounds" unless num >= 0 && num <= @max
    true
  end

  def validate!(num)
  end

  def mod_it(num)
    num % @max
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @max = num_buckets
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num) if self.include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @max]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @max = num_buckets
  end

  def insert(num)
    unless include?(num)
      if @count == @max
        resize!(num)
      else
        self[num] << num
        @count += 1
      end
    end
  end

  def remove(num)
    self[num].delete(num) if include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @max]
  end

  def num_buckets
    @store.length
  end

  def resize!(num)
    numbers = @store.flatten + [num]
    @max *= 2
    @count = 0
    @store = Array.new(@max) { Array.new }
    numbers.each { |num| self.insert(num) }
  end
end
