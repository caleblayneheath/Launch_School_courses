class GoodDog
  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} says \"Arf!\""
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end

  attr_accessor :name, :height, :weight
end

boy = GoodDog.new("Fido", 'tall', 'heavy')
puts boy.info
boy.change_info('Spot', 'short', 'light')
puts boy.info

