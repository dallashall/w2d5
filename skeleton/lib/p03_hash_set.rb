require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @max = num_buckets
  end

  def insert(key)
    unless include?(key)
      if @count == @max
        resize!(key)
      else
        @count += 1
        self[key] << key
      end
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key) if include?(key)
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
      @store[key.hash % @max]
  end

  def num_buckets
    @store.length
  end

  def resize!(key)
    keys = @store.flatten + [key]
    @count = 0
    @max *= 2
    @store = Array.new(@max) { Array.new }
    keys.each { |key| self.insert(key)}
  end
end
