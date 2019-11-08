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
      puts
    end
    display_goodbye_message
  end

  private

  attr_reader :human, :computer
  attr_accessor :round_winner, :history

  def initialize
    @human = Human.new
    @computer = Computer.new
    @round_winner = nil
    @history = { human.name => [], computer.name => [] }
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def determine_round_winner
    winner = if human.move > computer.move
               human
             elsif computer.move > human.move
               computer
             end

    return unless winner
    self.round_winner = winner.name
    winner.increase_score
  end

  def display_winner
    if round_winner
      puts "#{round_winner} wins the round!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end
    answer == 'y'
  end

  def display_round_start_message
    puts "Beginning game round."
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
  end

  def reset_scores
    human.reset_score
    computer.reset_score
  end

  def add_moves_to_history
    history[human.name].append(human.move.value)
    history[computer.name].append(computer.move.value)
  end

  def play_round
    loop do
      reset_round_winner
      display_round_start_message
      human.choose
      computer.choose
      add_moves_to_history
      display_moves
      determine_round_winner
      display_winner
      display_player_scores
      break if game_over?
    end
  end

  def display_move_history
    puts "#{human.name} has played: #{history[human.name].join(', ')}"
    puts "#{computer.name} has played: #{history[computer.name].join(', ')}"
  end
end

class Move
  include Comparable

  MATCHUPS = {
    'rock' =>
    { beats: ['lizard', 'scissors'], loses_to: ['paper', 'Spock'] },
    'paper' =>
    { beats: ['Spock', 'rock'], loses_to: ['lizard', 'scissors'] },
    'scissors' =>
    { beats: ['lizard', 'paper'], loses_to: ['rock', 'Spock'] },
    'lizard' =>
    { beats: ['paper', 'Spock'], loses_to: ['scissors', 'rock'] },
    'Spock' =>
    { beats: ['rock', 'scissors'], loses_to: ['paper', 'lizard'] }
  }

  VALUES = MATCHUPS.keys

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_s
    value
  end

  def >(other_move)
    MATCHUPS[value][:beats].include?(other_move.value)
  end

  def <(other_move)
    MATCHUPS[value][:loses_to].include?(other_move.value)
  end
end

class Player
  attr_reader :move, :name, :score

  def initialize
    @score = 0
    @move = nil
    set_name
  end

  def increase_score
    self.score += 1
  end

  def reset_score
    self.score = 0
  end

  private

  attr_writer :move, :name, :score
end

class Human < Player
  def choose
    input = nil
    loop do
      puts "Please choose (r)ock, (p)aper, (s)cissors, (l)izard, or (S)pock:"
      input = gets.chomp[0]
      break if ['r', 'p', 's', 'l', 'S'].include?(input)
      puts "Invalid choice."
    end
    self.move = Move.new(assign_choice(input))
  end

  private

  def assign_choice(choice)
    case choice
    when 'r' then 'rock'
    when 'p' then 'paper'
    when 's' then 'scissors'
    when 'l' then 'lizard'
    when 'S' then 'Spock'
    end
  end

  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must not be an empty string."
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
  end

  private

  attr_accessor :move_list

  def set_name
    self.name = ['R2D2', 'Hal', 'Johnny 5'].sample
  end

  def set_behavior
    choice = ''
    loop do
      puts "Would you like #{name} to play with its preferred style? (y/n)"
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

RPSGame.new.play
