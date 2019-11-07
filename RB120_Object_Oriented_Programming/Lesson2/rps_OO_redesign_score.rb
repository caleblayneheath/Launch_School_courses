class RPSGame 
  WINNING_SCORE = 3

  def initialize
    @human = Human.new
    @computer = Computer.new
    @round_winner = nil
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
    if human.move > computer.move
      self.round_winner = human.name
      human.increase_score
    elsif human.move < computer.move
      self.round_winner = computer.name
      computer.increase_score
    end
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

  def play
    display_welcome_message
    loop do
      reset_scores
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
      display_overall_winner
      break unless play_again?
    end
    display_goodbye_message
  end

  private
  
  attr_reader :human, :computer
  attr_accessor :round_winner
end

class Move
  include Comparable

  VALUES = ['rock', 'paper', 'scissors']
  def initialize(value)
    @value = value
  end

  def to_s
    value
  end

  def scissors?
    value == 'scissors'
  end

  def rock?
    value == 'rock'
  end

  def paper?
    value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  private

  attr_reader :value
end

class Player
  attr_reader :move, :name, :score

  def initialize(player_type = :human)
    @player_type = player_type
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

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Johnny 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

RPSGame.new.play
