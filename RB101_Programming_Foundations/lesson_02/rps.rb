VALID_CHOICES = %w(rock paper scissors)
TIE = "It's a tie!"
WIN = "You win!"
LOSE = "You lose!"
# player choice => computer choice 
GAME_STATES = {
  rock: {
    rock: TIE,
    paper: LOSE,
    scissors: WIN
  },
  paper: {
    rock: WIN,
    paper: TIE,
    scissors: LOSE
  },
  scissors: {
    rock: LOSE,
    paper: WIN,
    scissors: TIE
  }
}

def prompt(message)
  puts("=> #{message}")
end

def display_results(player, computer)
  puts GAME_STATES[player.to_sym][computer.to_sym]
end

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = gets.chomp
    VALID_CHOICES.include?(choice) ? break : prompt("That's not a valid choice")
  end

  computer_choice = VALID_CHOICES.sample

  puts "You chose #{choice}; Computer chose #{computer_choice}"

  display_results(choice, computer_choice)

  prompt('Play again? (y for yes)')
  break unless gets.chomp.downcase == 'y'
end

prompt('Bye bye!')
