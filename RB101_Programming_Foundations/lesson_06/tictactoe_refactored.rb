WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
PLAYER_NAME = 'Player'
COMPUTER_NAME = 'Computer'
CHOOSE = 'choose'
# options for FIRST_PLAYER are PLAYER_NAME, COMPUTER_NAME, and CHOOSE
FIRST_PLAYER = CHOOSE
WINS_NEEDED = 5

def prompt(msg)
  puts "=> #{msg}"
end

def display_board(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is a #{COMPUTER_MARKER}"
  puts ""
  puts " #{brd[1]} | #{brd[2]} | #{brd[3]} "
  puts "---|---|---"
  puts " #{brd[4]} | #{brd[5]} | #{brd[6]} "
  puts "---|---|---"
  puts " #{brd[7]} | #{brd[8]} | #{brd[9]} "
  puts ""
end

def initalize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

# returns array of integers expressing valid moves
def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

# returns string of integer square choices for player
def joinor(array, delimiter = ', ', word = 'or')
  if array.size >= 2
    [array[0..-2].join(delimiter), array[-1]].join("#{delimiter}#{word} ")
  else
    array.join(" #{word} ")
  end
end

def player_places_piece!(brd)
  square = nil
  loop do
    prompt "Choose a square: #{joinor(empty_squares(brd))}."
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

# computer prioritizes in order: offense, defense, center control;
# randomly selects valid move otherwise
def computer_places_piece!(brd)
  attack_square = priority_square(brd, 'attack')
  defend_square = priority_square(brd, 'defend')

  square = attack_square || defend_square ||
           center_square(brd) || empty_squares(brd).sample

  brd[square] = COMPUTER_MARKER
end

# if computer 'attack', finds line it has 2 marks in but player has none
# if computer 'defend', finds line player has 2 marks in but computer has none
# then returns integer corresponding to empty square
def priority_square(brd, mode)
  marker = COMPUTER_MARKER if mode == 'attack'
  marker = PLAYER_MARKER if mode == 'defend'
  WINNING_LINES.each do |line|
    line_values = brd.values_at(*line)
    if line_values.count(marker) == 2 &&
       line_values.count(INITIAL_MARKER) == 1
      return (line & empty_squares(brd)).fetch(0)
    end
  end
  nil
end

def center_square(brd)
  brd[5] == INITIAL_MARKER ? 5 : nil
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

# if line is full all of one player's marks, return string as winner
def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).all?(PLAYER_MARKER)
      return PLAYER_NAME
    elsif brd.values_at(*line).all?(COMPUTER_MARKER)
      return COMPUTER_NAME
    end
  end
  nil
end

def display_score(score_hsh)
  result = []
  score_hsh.each { |name, score| result << "#{name} score: #{score}" }
  prompt(result.join(' | '))
  prompt("#{WINS_NEEDED} wins are needed to end the game.")
end

# returns string for player who won enough games, else nil
def get_overall_winner(score_hsh)
  result = nil
  score_hsh.each { |name, wins| result = name if wins >= WINS_NEEDED }
  result
end

def place_piece!(brd, current_player)
  if current_player == PLAYER_NAME
    player_places_piece!(brd)
  elsif current_player == COMPUTER_NAME
    computer_places_piece!(brd)
  end
end

def set_first_player
  case FIRST_PLAYER
  when PLAYER_NAME
    PLAYER_NAME
  when COMPUTER_NAME
    COMPUTER_NAME
  when CHOOSE
    choose_player
  end
end

def choose_player
  input = nil
  loop do
    prompt("Who goes first? Player or computer?")
    prompt("Type 'P' for player or 'C' for computer.")

    input = gets.chomp.downcase
    break if ['p', 'c'].include?(input)
    prompt("Invalid input.")
  end

  case input
  when 'p'
    return PLAYER_NAME
  when 'c'
    return COMPUTER_NAME
  end
end

def switch_player(current_player)
  case current_player
  when PLAYER_NAME
    COMPUTER_NAME
  when COMPUTER_NAME
    PLAYER_NAME
  end
end

def play_again?
  answer = nil
  loop do
    prompt "Play again? (y or n)"
    answer = gets.chomp.downcase
    break if ['y', 'n'].include?(answer)
    prompt('Invalid input.')
  end

  return answer == 'y'
end

def display_winner(winner)
  prompt "#{winner} won!"
end

def update_score(score, winner)
  score[winner] += 1
end

def play_round(board, current_player)
  loop do
    display_board(board)
    place_piece!(board, current_player)
    current_player = switch_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end
  display_board(board)
end

def display_round_result(winner)
  case winner
  when PLAYER_NAME
    display_winner(PLAYER_NAME)
  when COMPUTER_NAME
    display_winner(COMPUTER_NAME)
  else
    prompt "It's a tie!"
  end
end

# needed to keep board and and winner message from instantly disappearing
def begin_next_round
  prompt('Press "enter" or "return" to begin next round.')
  gets
end

def display_overall_winner(overall_winner)
  prompt("#{overall_winner} won the game!") if overall_winner
end

def goodbye
  prompt("Thanks for playing Tic Tac Toe! Goodbye.")
end

loop do
  score = { PLAYER_NAME => 0, COMPUTER_NAME => 0 }

  loop do
    board = initalize_board
    current_player = set_first_player

    play_round(board, current_player)

    winner = detect_winner(board)

    update_score(score, winner)
    display_round_result(winner)
    display_score(score)

    overall_winner = get_overall_winner(score)
    display_overall_winner(overall_winner)
    break if !!overall_winner

    begin_next_round
  end

  break unless play_again?
end

goodbye
