produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}


def select_fruit(hsh)
  keys = hsh.keys
  results = {}
  
  counter = 0
  loop do
    break if counter == keys.size
    
    if hsh[keys[counter]] == 'Fruit'
      results[keys[counter]] = 'Fruit'
    end
    
    counter += 1
  end
  results

end


p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}