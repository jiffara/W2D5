require 'byebug'
class MaxIntSet

  attr_accessor :store

  def initialize(max)
    @store = Array.new(max)
  end

  def insert(num)
    store[num] = true if is_valid?(num)
  end

  def remove(num)
    store[num] = false if is_valid?(num)
  end

  def include?(num)
    store[num]
  end

  private


  def is_valid?(num)
    raise StandardError.new("Out of bounds") unless num.between?(0, store.length)
    true
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    # @store[num % @store.length] << num
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    # @store[num % @store.length].include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % @store.length]
    # optional but useful; return the bucket corresponding to `num`
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
  end

  def insert(num)
    if count >= num_buckets
      resize!
      self[num] << num
      @count += 1
    else
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = []
    @store.each do |bucket|
      bucket.each do |el|
        temp << el
      end
    end
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    temp.each do |el|
      self.insert(el)
    end
  end

end
