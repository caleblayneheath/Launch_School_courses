require 'pry'
require 'pry-byebug'
def wtf(a)
  a.odd?
end

i = 0
while i < 10
  a = i * i
  binding.pry
  puts a
  wtf(a)
  i += 1
end 
puts i