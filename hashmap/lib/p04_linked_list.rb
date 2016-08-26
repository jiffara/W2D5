require 'byebug'

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
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    return true if @head.next == @tail
    false
  end

  def get(key)
    self.each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    self.each do |link|
      return true if link.key == key
    end
    false

  end

  def insert(key, val)
    new_link = Link.new(key, val)
    if empty?
      @head.next, @tail.prev = new_link, new_link
      new_link.prev, new_link.next = @head, @tail
    else
      new_link.next, new_link.prev = @tail, last
      last.next, @tail.prev = new_link, new_link
    end
  end

  def remove(key)
    self.each do |link|
      if link.key == key
        # debugger
        link.prev.next = link.next
        link.next.prev = link.prev
      end
    end
  end

  def each(&prc)
    current_next = @head.next
    until current_next == @tail
      prc.call(current_next)
      current_next = current_next.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

# linklist = LinkedList.new
# linklist.insert(:first, 1)
# linklist.insert(:second, 2)
# linklist.insert(:third, 3)
# linklist.remove(:second)
