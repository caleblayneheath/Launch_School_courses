class Array
  def my_each
    index = 0
    while index < self.size do
      if block_given?
        yield(self[index])
        index += 1
      else
        break
      end
    end
    self
  end
end

arr = [1, 2, 3]

p arr.each { |elem| puts elem }
p arr.my_each { |elem| puts elem }

p arr.my_each.select(&:odd?)