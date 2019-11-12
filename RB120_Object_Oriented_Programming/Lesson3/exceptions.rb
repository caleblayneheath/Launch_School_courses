begin
  5/0
rescue StandardError => e
  puts e.message
  puts e.class
  puts e.backtrace
end

module Describable 
  def describe_shape
    "I am a #{self.class} and have #{self.class::SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    self::SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4

  def sides; SIDES; end
end

class Square < Quadrilateral; end

puts Square.sides # => 4
puts Square.new.sides # => 4
puts Square.new.describe_shape # => "I am a Square and have 4 sides."