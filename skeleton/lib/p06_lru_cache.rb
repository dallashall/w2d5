require_relative 'p05_hash_map'
require_relative 'p04_linked_list'


class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    v = nil
    node = @map.get(key)
    if node
      v = @map.delete(node.key).val
      @store.remove(node.key)
    else
      eject! if (count == @max)
      v = calc!(key)
    end
    @map.set(key, @store.append(key, v))
    v
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    key_to_remove = @store.first.key
    @store.remove(key_to_remove)
    @map.delete(key_to_remove)
  end
end
