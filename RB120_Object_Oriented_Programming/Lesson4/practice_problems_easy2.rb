# Question 3

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

puts Orange.ancestors
puts Orange.new.ancestors

=begin
Benefits of using Object Oriented Programming in Ruby

- Breaks large blocks of procedural code into interactions of distinct objects.
- Modularizes code because interacting objects can be refigured or added/deleted
  as long as methods speak a similar language.
- In Ruby, the fact that everything is an object provides a unified model for how
  language features work.
- Chunks of code can be arranged heirarchically or put into modules which expand functionality.
- Programs can be described in terms of real-world states and actions more easily.
- Objects internal representations can be kept private, 
  protecting data and limiting namespace conflicts

1. Creating objects allows programmers to think more abstractly about the code they are writing.
2. Objects are represented by nouns so are easier to conceptualize.
3. It allows us to only expose functionality to the parts of code that need it,
   meaning namespace issues are much harder to come across.
4. It allows us to easily give functionality to different parts of an application without duplication.
5. We can build applications faster as we can resue pre-written code.
6. As the software becomes more complex this complexity can be more easily managed.

=end