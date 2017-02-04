class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index do |num, idx|
      num = num.hash if num.is_a?(Array)
      sum += num.ord * (idx + 1)
    end
    sum.hash
  end
end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = []
    self.each do |key, val|
      arr << key.to_s.ord.hash + val.ord
    end
    arr.inject(&:+).hash
  end
end
