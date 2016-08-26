require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    # @store.each do |list|
    #   list.each do |link|
    #     return true if link.key == key
    #   end
    # end
    self.each do |k,v|
      return true if k == key
    end
    false
  end

  def set(key, val)
    reassigned = false
    resize! if @count >= num_buckets
    @store.each do |list|
      list.each do |link|
        link.val = val if link.key == key
        reassigned = true
      end
    end
    # @store[key.hash % num_buckets].insert(key, val)
    unless reassigned
      bucket(key).insert(key,val)
      @count += 1
    end
  end

  def get(key)
    self.each do |k, v|
      return v if k == key
    end
    nil

    # result = nil
    # @store.each do |list|
    #   result = list.get(key)
    #   return result unless result.nil?
    # end
    # result
  end

  def delete(key)
    @store[key.hash % num_buckets].remove(key)
    @count -= 1
  end

  def each(&prc)

    @store.each do |list|
      list.each do |link|
        prc.call(link.key, link.val)
      end
    end

  end

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
    old_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    old_store.each do |list|
      list.each do |link|
        bucket(link.key).insert(link.key, link.val)
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end

end
