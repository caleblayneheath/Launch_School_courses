# Practice Problem 1
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
hsh = {}
flintstones.each_with_index { |value, index| hsh[value] = index }

# Practice Problem 2
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
ages.values.sum

# Practice Problem 3
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.reject! { |key, value| value >= 100 }

# Practice Problem 4
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
ages.values.min

# Practice Problem 5
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
result = nil
flintstones.each_with_index do |name, index| 
  if name.slice(0..1) == 'Be'
    result = index
    break
  end
end
result
# flintstones.index { |name| name[0,2] == 'Be' }

# Practice Problem 6
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.map! { |name| name[0,3] }

# Practice Problem 7 
statement = "The Flintstones Rock"
hsh = Hash.new(0)
statement.each_char { |char| hsh[char] += 1 }

# Practice Problem 9
def titleize(string)
  # string.split.map { |word| word[0].upcase + word[1..-1] }.join(' ')
  string.split.map { |word| word.capitalize }.join(' ')
end

words = "the flintstones rock"
titleize(words)

# Practice Problem 10
KID_AGE = 0..17
ADULT_AGE = 18..64
SENIOR_AGE = 65..Float::INFINITY

def determine_age_group(age)
  return 'kid' if KID_AGE.include?(age)
  return 'adult' if ADULT_AGE.include?(age)
  return 'senior' if SENIOR_AGE.include?(age)
end

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |key, value|
  age_group = determine_age_group(value['age'])
  value['age_group'] = age_group
end

# munsters.each do |name, details|
#   case details["age"]
#   when 0...18
#     details["age_group"] = "kid"
#   when 18...65
#     details["age_group"] = "adult"
#   else
#     details["age_group"] = "senior"
#   end
# end