class GoodDog
  DOG_YEARS = 7
  def what_is_self
    self
  end

  def to_s
    "My name is #{name} and I love you!"
  end

  def initialize(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
    self.age = 1 * DOG_YEARS
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

  puts self
end

boy = GoodDog.new("Fido", 'tall', 'heavy')
puts boy.info
boy.change_info('Spot', 'short', 'light')
puts boy.info

