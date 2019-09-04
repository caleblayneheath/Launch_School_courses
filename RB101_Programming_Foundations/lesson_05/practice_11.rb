arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

arr1 = arr.map do |sub_array|
  sub_array.select { |elem| elem % 3 == 0 }
end

p arr1
