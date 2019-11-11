class RPSGame
  WINNING_SCORE = 10

  def play
    display_welcome_message
    loop do
      reset_scores
      play_round
      display_overall_winner
      display_move_history
      break unless play_again?
    end
    display_goodbye_message
  end

  private

  attr_reader :human, :computer
  attr_accessor :round_winner

  def initialize
    @human = Human.new
    @computer = Computer.new
    @round_winner = nil
  end

  def display_welcome_message
    system('clear')
    puts "Welcome to Rock, Paper, Scissors!"
    puts
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def determine_round_winner
    winner = if human.move.beats?(computer.move)
               human
             elsif computer.move.beats?(human.move)
               computer
             end

    return unless winner
    self.round_winner = winner.name
    winner.increase_score
  end

  def display_winner
    puts
    if round_winner
      puts "#{round_winner} wins the round!"
    else
      puts "It's a tie!"
    end
    puts
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end
    system('clear')
    answer == 'y'
  end

  def display_round_start_message
    puts "Beginning game round."
    puts
  end

  def display_player_scores
    puts "#{human.name} has #{human.score} points."
    puts "#{computer.name} has #{computer.score} points."
    puts
  end

  def reset_round_winner
    self.round_winner = nil
  end

  def game_over?
    human.score >= WINNING_SCORE || computer.score >= WINNING_SCORE
  end

  def display_overall_winner
    overall_winner = if human.score >= WINNING_SCORE
                       human.name
                     else
                       computer.name
                     end
    puts "#{overall_winner} won the game!"
    puts
  end

  def reset_scores
    human.reset_score
    computer.reset_score
  end

  def play_round
    loop do
      reset_round_winner
      display_round_start_message
      human.choose
      computer.choose
      display_moves
      determine_round_winner
      display_winner
      display_player_scores
      break if game_over?
    end
  end

  def display_move_history
    puts "#{human.name} has played: #{human.move_history.join(', ')}"
    puts "#{computer.name} has played: #{computer.move_history.join(', ')}"
    puts
  end
end

class Move
  WINNING_MATCHUPS = {
    'rock' => ['lizard', 'scissors'],
    'paper' => ['Spock', 'rock'],
    'scissors' => ['lizard', 'paper'],
    'lizard' => ['paper', 'Spock'],
    'Spock' => ['rock', 'scissors']
  }

  VALUES = WINNING_MATCHUPS.keys

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_s
    value
  end

  def beats?(other_move)
    WINNING_MATCHUPS[value].include?(other_move.value)
  end
end

class Player
  attr_reader :move, :name, :score, :move_history

  def initialize
    @score = 0
    @move = nil
    @move_history = []
    set_name
  end

  def increase_score
    self.score += 1
  end

  def reset_score
    self.score = 0
  end

  private

  def add_move_to_history
    move_history.append(move)
  end

  attr_writer :move, :name, :score
end

class Human < Player
  def choose
    input = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or Spock:"
      input = gets.chomp
      input = assign_move(input)
      break if valid_move?(input)
      puts "Invalid move."
    end
    system('clear')
    self.move = Move.new(input)
    add_move_to_history
  end

  private

  def valid_move?(input)
    Move::VALUES.include?(input)
  end

  def assign_move(input)
    input = input.downcase
    if input.start_with?('ro') then 'rock'
    elsif input.start_with?('pa') then 'paper'
    elsif input.start_with?('sc') then 'scissors'
    elsif input.start_with?('li') then 'lizard'
    elsif input.start_with?('sp') then 'Spock'
    end
  end

  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.delete(' ').empty?
      puts "Sorry, your name must not be an empty string."
    end
    self.name = n
  end
end

class Computer < Player
  # random selections with different arrays of choices
  PLAY_STYLE = {
    'default' => Move::VALUES,
    'R2D2' => ['rock'],
    'Hal' => (['scissors'] * 4) + (['lizard', 'Spock'] * 2) + ['rock'],
    'Johnny 5' => (['lizard', 'Spock'] * 3) + ['scissors']
  }

  def initialize
    super
    set_behavior
  end

  def choose
    self.move = Move.new(move_list.sample)
    add_move_to_history
  end

  private

  attr_accessor :move_list

  def set_name
    self.name = ['R2D2', 'Hal', 'Johnny 5'].sample
  end

  def set_behavior
    choice = ''
    loop do
      puts "Would you like #{name} to play using its preferred style? (y/n)"
      choice = gets.chomp.downcase
      break if ['y', 'n'].include?(choice)
      puts "You must enter 'y' or 'n'."
    end

    @move_list = if choice == 'y'
                   PLAY_STYLE[name]
                 elsif choice == 'n'
                   PLAY_STYLE['default']
                 end
  end
end

system('clear')
RPSGame.new.play
