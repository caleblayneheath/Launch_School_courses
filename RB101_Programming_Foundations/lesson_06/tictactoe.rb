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
  square = ''
  loop do
    prompt "Choose a square: #{joinor(empty_squares(brd))}."
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

# computer prioritizes offense, defense, center control
# randomly selects valid move otherwise
def computer_places_piece!(brd)
  attack_square = priority_square(brd, 'attack')
  defend_square = priority_square(brd, 'defend')

  square = if !attack_square.nil?
             attack_square
           elsif !defend_square.nil?
             defend_square
           elsif center_free?(brd)
             5
           else
             empty_squares(brd).sample
           end
  brd[square] = COMPUTER_MARKER
end

# if computer 'attack', finds line it has 2 marks in but player has none
# if computer 'defend', finds line player has 2 marks in but computer has none
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

def center_free?(brd)
  brd[5] == INITIAL_MARKER
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

def display_wins(score_hsh)
  result = []
  score_hsh.each { |name, score| result << "#{name} score: #{score}" }
  prompt(result.join(' | '))
end

# returns name of winner as string
def get_overall_winner(score_hsh)
  result = ''
  score_hsh.each { |name, wins| result = name if wins >= 5 }
  result
end

def place_piece!(brd, current_player)
  if current_player == PLAYER_NAME
    player_places_piece!(brd)
  elsif current_player == COMPUTER_NAME
    computer_places_piece!(brd)
  end
end

def who_goes_first
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
  loop do
    prompt("Who goes first? Player or computer?")
    prompt("Type 'P' for player or 'C' for computer.")
    input = gets.chomp.downcase[0]
    if input == 'p'
      return PLAYER_NAME
    elsif input == 'c'
      return COMPUTER_NAME
    else
      prompt('Invalid entry.')
    end
  end
end

def alternate_player(current_player)
  case current_player
  when PLAYER_NAME
    COMPUTER_NAME
  when COMPUTER_NAME
    PLAYER_NAME
  end
end

loop do
  score = { PLAYER_NAME => 0, COMPUTER_NAME => 0 }

  loop do
    board = initalize_board
    current_player = who_goes_first
    loop do
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)

    if someone_won?(board)
      winner = detect_winner(board)
      prompt "#{winner} won!"
      score[winner] += 1
    else
      prompt "It's a tie!"
    end

    display_wins(score)

    overall_winner = get_overall_winner(score)

    if overall_winner != ''
      prompt("#{overall_winner} won the most games!")
      break
    end

    prompt('Press "enter" or "return" to begin next game.')
    gets
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Goodbye."
