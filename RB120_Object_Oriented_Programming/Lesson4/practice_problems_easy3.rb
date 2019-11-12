# Question 1
# class Greeting
#   def greet(message)
#     puts message
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
# case 1:
# hello = Hello.new
# hello.hi  # output "Hello"
# 
# case 2:
# hello = Hello.new
# hello.bye # error, no bye method in Hello
# 
# case 3:
# hello = Hello.new
# hello.greet # error, greet needs one argument
# 
# case 4:
# hello = Hello.new
# hello.greet("Goodbye") # puts "Goodbye"
# 
# case 5:
# Hello.hi # no class method error

# Question 2
# class Greeting
#   def greet(message)
#     puts message
#   end
# end
# 
# class Hello < Greeting
#   def self.hi
#     greeting = Greeting.new
#     greeting.greet("Hello")
#   end
# end
# 
# class Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end
# 
# Hello.hi

# Question 4
# class Cat
#   def initialize(type)
#     @type = type
#   end
# 
#   def to_s
#     "I am a #{@type}"
#   end
# end
# 
# puts Cat.new('tabby cat')

