# arr = %w(cat sheep bear)
# p arr.reduce { |sum, n| sum + n }
require 'pry-byebug'

# def reduce(collection, default = collection.first) #default initial value is first element
#   # counter = default == collection.first ? 1 : 0
#   counter = 1
#   accumulator = default
#   while counter < collection.size do
#     accumulator = yield(accumulator, collection[counter])
#     counter += 1
#   end
#   accumulator
# end

def reduce(collection, default = omitted = true)
  accumulator = omitted ? collection.first : default
  counter = omitted ? 1 : 0
  while counter < collection.size do
    accumulator = yield(accumulator, collection[counter])
    counter += 1
  end
  accumulator
end

array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 1) { |acc, num| acc + num }                    # => 16
p reduce(array, 10) { |acc, num| acc + num }                # => 25
# p reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass
p reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']