# This statement tries to implicitly convert 40 + 2 to a string.
# puts "the value of 40 + 2 is " + (40 + 2)

# Conversion must be done more explicitly
puts "the value of 40 + 2 is " + (40 + 2).to_s

# or a little less obviously
puts "the value of 40 + 2 is #{40 + 2}"

