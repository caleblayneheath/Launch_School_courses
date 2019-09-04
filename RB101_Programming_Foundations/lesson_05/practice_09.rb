arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

arr2 = arr.map do |elem|
  elem.sort { |a, b| b <=> a }
end

p arr2