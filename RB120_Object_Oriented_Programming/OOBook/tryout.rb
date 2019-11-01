module Brush
  def brush
    puts "You brush the kitty."
  end
end

class Cat
  include Brush
  @@haz_borger = false
  CUTE = true

  def self.no_borger
    @@haz_borger = false
  end

  def self.purr
    puts "PUUUUURRRRRRRR" if @@haz_borger
  end

  def initialize(color, breed)
    self.color = color
    self.breed = breed
    @@haz_borger = true
  end

  def to_s
    "That #{self.breed} is #{CUTE} "
  end
  attr_accessor :color, :breed

end


class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  attr_accessor :name

  def initialize(n)
    self.name = n
  end

  def speak
    "#{self.name} says arf!"
  end
end

class Cat < Animal
end

sparky = GoodDog.new
paws = Cat.new
puts sparky.speak
puts paws.speak


class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

class BadDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
  end
end

sparky = GoodDog.new
sparky.speak


module Swimmable
  def swim
    "I'm swimming!"
  end
end

class Animal
end

class Fish < Animal
  include Swimmable
end

class Mammal < Animal
end

class Cat < Mammal
end

class Dog < Mammal
  include Swimmable
end


module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

class GoodDog < Animal
  include Swimmable
  include Climbable
end



module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end

  def self.some_method(num)
    num ** 2
  end
end




class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
  end

  def public_disclosure
    "#{self.name} in human years is #{self.human_years}"
  end

  protected

  def human_years
    age * DOG_YEARS
  end
end

class Animal
  def a_public_method
    "Will this work? " + self.a_protected_method
  end

  protected

  def a_protected_method
    "Yes, I'm protected!"
  end

end


class Parent
  def say_hi
    p "Hi from Parent."
  end
end

class Child
  def say_hi
    p "Hi from Child."
  end

  def send
    p "send from Child..."
  end

  def instance_of?
    p "I am a fake instance"
  end
end

lad = Child.new