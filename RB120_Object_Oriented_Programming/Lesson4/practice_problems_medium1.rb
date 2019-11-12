# Question 4
# class Greeting
#   def greet(str)
#     puts str
#   end
# end
# 
# class Hello < Greeting
#   def hi
#     greet("Hello")
#   end
# end
# 
# class Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end
# 
# Hello.new.hi
# Goodbye.new.bye

# Question 5
# class KrispyKreme
#   def initialize(filling_type, glazing)
#     @filling_type = filling_type
#     @glazing = glazing
#   end
# 
#   def to_s
#     filling = @filling_type.nil? ? 'Plain' : @filling_type
# 
#     if @glazing.nil?
#       "#{filling}"
#     else
#       "#{filling} with #{@glazing}"
#     end
#   end
# end
# 
# donut1 = KrispyKreme.new(nil, nil)
# donut2 = KrispyKreme.new("Vanilla", nil)
# donut3 = KrispyKreme.new(nil, "sugar")
# donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
# donut5 = KrispyKreme.new("Custard", "icing")
# puts donut1
# puts donut2
# puts donut3
# puts donut4
# puts donut5

