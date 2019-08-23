def double_odd_index_numbers(numbers)
  results = []
  counter = 0
  loop do
    break if counter == numbers.size
    
    if counter.odd?
      results << numbers[counter] * 2
    else
      results << numbers[counter]
    end
    counter += 1
  end
  
  results
end

my_numbers = [1, 4, 3, 7, 2, 6]

p double_odd_index_numbers(my_numbers)  
# not mutated
p my_numbers           