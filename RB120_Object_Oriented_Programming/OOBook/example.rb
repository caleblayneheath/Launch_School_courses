

# module Genes
#   def show_ancestry(a_class)
#     puts a_class.ancestors
#   end
# end

# class Card
#   include Genes
# end

# Card.new.show_ancestry(Card)




class MyCar
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up
    self.speed += 1
  end

  def brake
    self.speed -= 1
  end

  def shut_off
    self.speed = 0
  end

  def display_speed
    puts self.speed
  end

  attr_accessor :year, :color, :model, :speed
end

hooptie = MyCar.new(2009, 'grey', 'honda')
hooptie.speed_up
hooptie.display_speed
hooptie.speed_up
hooptie.display_speed
hooptie.speed_up
hooptie.display_speed
hooptie.brake
hooptie.display_speed
hooptie.shut_off
hooptie.display_speed