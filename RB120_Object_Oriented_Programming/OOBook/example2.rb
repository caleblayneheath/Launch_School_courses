module Weapons
  def fire_missiles
    puts 'Missiles away!'
  end
end

module Towable
  def tow_load
    puts "You tow a load."
  end
end

class Vehicle
  include Weapons
  
  @@number_of_vehicles = 0

  def self.number_of_vehicles
    @@number_of_vehicles
  end

  def initialize(color, year, model)
    self.color = color
    self.model = model
    @year = year
    self.speed = 0
    @@number_of_vehicles += 1
  end

  def self.what_am_i
    puts "I'm a vehicle!"
  end

  def speed_up(change = 1)
    self.speed += change
  end

  def brake(change = 1)
    self.speed -= change
    self.speed = 0 if self.speed < 0
  end

  def spray_paint(color)
    self.color = color
    puts "Pay'n Spray!"
  end

  def to_s
    "This is a #{color} #{model}."
  end

  def self.mileage(miles, gallons)
    miles / gallons.to_f
  end

  def shut_off
    self.speed = 0
  end

  def age
    calc_age
  end

  attr_accessor :speed, :color, :model
  attr_reader :year

  private
  def calc_age
    Time.new.year - year
  end
end

class MyTruck < Vehicle
  include Towable
  LICENSE_REQUIRED = 'extended'
end

class MyCar < Vehicle
  LICENSE_REQUIRED = 'standard'
end


class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(student)
    self.grade > student.grade
  end

  attr_reader :name

  protected
  attr_reader :grade
end