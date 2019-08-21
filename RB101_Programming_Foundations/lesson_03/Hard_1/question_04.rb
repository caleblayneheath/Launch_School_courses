def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.size == 4

  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false unless true #is_an_ip_number?(word)
  end
  
  true
end

puts dot_separated_ip_address?("10.4.5.11")