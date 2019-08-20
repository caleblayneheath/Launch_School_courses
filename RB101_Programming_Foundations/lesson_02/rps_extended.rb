VALID_CHOICES = %w(rock paper scissors lizard Spock)
SHORT_CHOICES = {
  r: VALID_CHOICES[0],
  p: VALID_CHOICES[1],
  s: VALID_CHOICES[2],
  l: VALID_CHOICES[3],
  S: VALID_CHOICES[4]
}
TIE = "It's a tie!"
WIN = "You win!"
LOSE = "You lose!"
# player choice => computer choice
GAME_STATES = {
  rock: {
    rock: TIE,
    paper: LOSE,
    scissors: WIN,
    lizard: WIN,
    Spock: LOSE
  },
  paper: {
    rock: WIN,
    paper: TIE,
    scissors: LOSE,
    lizard: LOSE,
    Spock: WIN
  },
  scissors: {
    rock: LOSE,
    paper: WIN,
    scissors: TIE,
    lizard: WIN,
    Spock: LOSE
  },
  lizard: {
    rock: LOSE,
    paper: WIN,
    scissors: LOSE,
    lizard: TIE,
    Spock: WIN
  },
  Spock: {
    rock: WIN,
    paper: LOSE,
    scissors: WIN,
    lizard: LOSE,
    Spock: TIE
  }
}

def prompt(message)
  puts("=> #{message}")
end

def display_results(player, computer)
  puts GAME_STATES[player.to_sym][computer.to_sym]
end

def player_win?(player, computer)
  GAME_STATES[player.to_sym][computer.to_sym] == WIN
end

def comp_win?(player, computer)
  GAME_STATES[player.to_sym][computer.to_sym] == LOSE
end

player_score = 0
computer_score = 0
loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    prompt("Just the first letter (case-sensitive) is fine!")
    choice = gets.chomp[0].to_sym
    # if VALID_CHOICES.include?(choice)
    if SHORT_CHOICES.include?(choice)
      choice = SHORT_CHOICES[choice]
      break
    else
      prompt("That's not a valid choice")
    end
  end

  computer_choice = VALID_CHOICES.sample

  puts "You chose #{choice}; Computer chose #{computer_choice}"

  # binding.pry
  display_results(choice, computer_choice)

  if player_win?(choice, computer_choice) && !comp_win?(choice, computer_choice)
    player_score += 1
  end
  if !player_win?(choice, computer_choice) && comp_win?(choice, computer_choice)
    computer_score += 1
  end

  prompt("The score is player: #{player_score}, computer: #{computer_score}.")
  break if player_score == 5 || computer_score == 5


  prompt('Play again? (y for yes, else any key to quit)')
  break unless gets.chomp.downcase == 'y'
end

prompt("The final score was player: #{player_score}, computer: #{computer_score}.")
prompt('Bye bye!')
