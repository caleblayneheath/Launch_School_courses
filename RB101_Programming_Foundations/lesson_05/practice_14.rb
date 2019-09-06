hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

results = []
hsh1 = hsh.each_value do |sub_hash|
  if sub_hash[:type] == 'fruit'
    results << sub_hash[:colors].map(&:capitalize)
  elsif sub_hash[:type] == 'vegetable'
    results << sub_hash[:size].upcase
  end
end

p results