class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    self.each_with_index do |el, i|
      result += (el.hash + i).hash
    end
    result
  end
end

class String
  def hash
    arr = self.split("").map!(&:ord)
    arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0
    self.keys.each do |key|
      result += key.hash
    end

    self.values.each do |value|
      result += value.hash
    end
    result
  end
end
