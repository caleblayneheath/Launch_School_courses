arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]
p arr.sort
# [[1, 8, 3], [1, 6, 7], [1, 4, 9]]


arr1 = arr.map do |sub_array|
  # sub_array.sort_by { sub_array.select { |i| i.odd?}. sort }

  # sub_array.sort_by do 
  #   p sub_array.map do |elem|
  #     elem = nil if elem.even?
  #   end
  # end

  sub_array.sort_by do |a, b|
    # a.select(&:odd?) <=> b.select(&:odd?)
  end

end

p arr1

# [[1, 7], [1, 9], [1, 3]]