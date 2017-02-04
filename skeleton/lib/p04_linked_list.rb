require "byebug"
class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev = nil
    @next = nil
    self
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  # attr_reader :sentinel
  def initialize
    @sentinel = Link.new
    @sentinel.next = @sentinel
    @sentinel.prev = @sentinel
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @sentinel.next
  end

  def last
    @sentinel.prev
  end

  def empty?
    @sentinel.next == @sentinel
  end

  def get(key)
    node = get_node(key)
    node ? node.val : nil
  end

  def get_node(key)
    current = @sentinel.prev
    until current == @sentinel
      return current if current.key == key
      current = current.prev
    end
    nil
  end

  def include?(key)
    current = @sentinel.prev
    until current == @sentinel
      return true if current.key == key
      current = current.prev
    end
    false
  end

  def append(key, val)
    old_prev = @sentinel.prev
    new_link = Link.new(key, val)
    @sentinel.prev = new_link
    new_link.next = @sentinel
    new_link.prev = old_prev
    old_prev.next = new_link
    new_link
  end

  def update(key, val)
    node = get_node(key)
    node.val = val if node
  end

  def remove(key)
    node = get_node(key)
    if node
      prev_node = node.prev
      next_node = node.next
      prev_node.next = next_node
      next_node.prev = prev_node
      node.remove
    end
  end

  def each(&prc)
    current = first
    until current == @sentinel
      prc.call(current)
      current = current.next
    end
  end

  include Enumerable

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
