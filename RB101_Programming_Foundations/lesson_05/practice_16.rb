HEXDIGITS = ('0'..'9').to_a + ('a'..'f').to_a
UUID_LENGTHS = [8, 4, 4, 4, 12]

def create_UUID
  result = []
  counter = 0
  while counter < UUID_LENGTHS.length
    string = ''
    UUID_LENGTHS[counter].times do
      string << HEXDIGITS.sample 
    end
    result << string
    counter += 1
  end
  result.join('-')
end

p create_UUID