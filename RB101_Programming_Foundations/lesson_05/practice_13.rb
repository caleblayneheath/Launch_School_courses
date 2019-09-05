arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]
p arr.sort
# [[1, 8, 3], [1, 6, 7], [1, 4, 9]]

arr1 = arr.sort do |a, b|
  a.select(&:odd?) <=> b.select(&:odd?)
end

p arr1