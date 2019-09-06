arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

# results = []
# arr.each do |hash| 
#   temp_hsh = {}
#   hash.each do |key, value|
#     if value.all?(&:even?)
#       temp_hsh[key] = value
#     end
#   end
#   if temp_hsh == hash
#     results << temp_hsh
#   end
# end

results = arr.select do |hash|
  hash.all? do |key, value|
    value.all?(&:even?)
  end
end

p results