require 'pry-byebug'

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = HUMAN_MARKER
  SCORE_TO_WIN = 2

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
    @round_winner = nil
  end

  def play
    clear
    display_welcome_message
    loop do
      play_round
      display_game_result
      break unless play_again?
      reset(new_game: true)
      display_play_again_message
    end
    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer, :current_player

  def play_round
    loop do
      display_board
      loop do
        current_player_moves
        break if board.someone_won_round? || board.full?
        clear_screen_and_display_board if human_turn?
      end
      set_round_winner_and_score
      display_round_result
      break if someone_won_game?
      start_next_round
    end
  end

  def clear
    system('clear')
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts
  end

  def display_board
    puts "You're a #{HUMAN_MARKER}. Computer is a #{COMPUTER_MARKER}."
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def current_player_moves
    human_turn? ? human_moves : computer_moves
    @current_marker = human_turn? ? COMPUTER_MARKER : HUMAN_MARKER
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)})"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, not a valid choice."
    end
    board[square] = human.marker
  end

  def computer_moves
    squares_to_defend = board.threatened_squares(COMPUTER_MARKER)

    square = if !squares_to_defend.empty?
               squares_to_defend.sample
             else
               board.unmarked_keys.sample
             end
    board[square] = computer.marker
  end

  def joinor(list, delimiter = ', ', conjunction = 'or')
    if list.size == 2
      "#{list.first} #{conjunction} #{list.last}"
    elsif list.size >= 3
      "#{list[0..-2].join(delimiter)}#{delimiter}#{conjunction} #{list.last}"
    else
      list.join
    end
  end

  def set_round_winner_and_score
    @round_winner = case board.winning_marker
                    when HUMAN_MARKER then human
                    when COMPUTER_MARKER then computer
                    end
    @round_winner&.increase_score
  end

  def someone_won_game?
    human.score >= SCORE_TO_WIN || computer.score >= SCORE_TO_WIN
  end

  def display_round_result
    clear_screen_and_display_board
    case @round_winner
    when human
      puts "You won the round!"
    when computer
      puts "Computer won the round!"
    else
      puts "Tie round; the board is full!"
    end
    display_score
  end

  def display_score
    puts
    puts "The score is Human-#{human.score} to Computer-#{computer.score}."
    puts
  end

  def start_next_round
    puts "Press enter to start new round."
    gets.chomp
    reset
  end

  def display_game_result
    str = if computer.score == human.score
            "It's a tie!"
          elsif human.score >= SCORE_TO_WIN
            "Human won the game!"
          elsif computer.score >= SCORE_TO_WIN
            "Computer won the game!"
          end
    puts str
    puts
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def reset(new_game: false)
    board.reset
    @current_marker = FIRST_TO_MOVE
    if new_game
      human.reset_score
      computer.reset_score
    end
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def threatened_squares(player_marker)
    squares_to_claim = []
    WINNING_LINES.each do |line|
      markers = @squares.values_at(*line).map(&:marker)
      if two_claimed_and_one_unclaimed_square?(markers, player_marker)
        line.each { |key| squares_to_claim << key if @squares[key].unmarked? }
      end
    end
    squares_to_claim
  end

  def two_claimed_and_one_unclaimed_square?(markers, player_marker)
    markers.count(player_marker) == 2 &&
      markers.count(Square::INITIAL_MARKER) == 1
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won_round?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_identical_markers(squares)
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new(Square::INITIAL_MARKER) }
  end

  def three_identical_markers(squares)
    markers = squares.select(&:marked?).map(&:marker)
    markers.count(markers.first) == 3
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker, :score

  def initialize(marker)
    @marker = marker
    @score = 0
  end

  def increase_score
    @score += 1
  end

  def reset_score
    @score = 0
  end
end

game = TTTGame.new
game.play
