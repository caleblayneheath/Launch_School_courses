class Auto
end

class Car < Auto
  attr_accessor :wheels, :name
  
  def initialize
    @wheels = 4
  end
end