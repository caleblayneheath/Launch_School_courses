# Question 2
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Vehicle; include Speed; end

class Car < Vehicle
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck < Vehicle
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

puts Car.new.go_slow
puts Car.new.go_fast
puts Truck.new.go_very_slow
puts Truck.new.go_fast

# Question 4

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

p AngryCat.new

# Question 6

class Cube
  def initialize(volume)
    @volume = volume
  end

  def volume
    @volume
  end
end


