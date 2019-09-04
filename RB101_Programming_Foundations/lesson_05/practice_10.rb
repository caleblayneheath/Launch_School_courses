arr1 = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

# arr2 = arr1.map do |hash|
#   hash.transform_values { |value| value += 1 }
# end

arr2 = arr1.map do |hash|
  new_hash = {}
  hash.each do |key, value|
    new_hash[key] = value + 1
  end
  new_hash
end

p arr2