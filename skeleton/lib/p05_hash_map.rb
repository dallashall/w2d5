require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
    @max = num_buckets
  end

  def include?(key)
    get_list(key).include?(key)
  end

  def set(key, val)
    list = get_list(key)
    if list.include?(key)
      list.update(key, val)
    else
      resize! if @count == @max
      @count += 1
      list.append(key, val)
    end
  end

  def get(key)
    get_list(key).get(key)
  end


  def delete(key)
    list = get_list(key)
    if list.include?(key)
      @count -= 1
      list.remove(key)
    end
  end

  def each(&prc)
    @store.each do |list|
      list.each { |el| prc.call(el.key, el.val)}
    end
  end

  include Enumerable

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    @max *= 2
    @count = 0
    pairs = []
    @store.each do |list|
      list.each { |el| pairs << [el.key, el.val]}
    end
    @store = Array.new(@max) { LinkedList.new }

    pairs.each { |pair| self.set(pair[0], pair[1])}
  end

  def get_list(key)
    @store[key.hash % @max]
  end
end
