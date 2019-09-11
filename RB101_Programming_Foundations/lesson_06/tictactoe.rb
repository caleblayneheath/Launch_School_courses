require 'pry'
require 'pry-byebug'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

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

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

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

def computer_places_piece!(brd)
  line_of_defense = get_line_of_defense(brd)
  square = if !line_of_defense.empty?
             (line_of_defense & empty_squares(brd)).fetch(0)
           else
             empty_squares(brd).sample
           end
  brd[square] = COMPUTER_MARKER
end

def get_line_of_defense(brd)
  WINNING_LINES.each do |line|
    line_values = brd.values_at(*line)
    if line_values.count(PLAYER_MARKER) == 2 &&
       line_values.count(COMPUTER_MARKER) == 0
      return line
    end
  end
  []
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).all?(PLAYER_MARKER)
      return 'Player'
    elsif brd.values_at(*line).all?(COMPUTER_MARKER)
      return 'Computer'
    end
  end
  nil
end

def display_wins(score_hsh)
  result = []
  score_hsh.each { |name, score| result << "#{name} score: #{score}" }
  prompt(result.join(' | '))
end

def get_overall_winner(score_hsh)
  result = ''
  score_hsh.each { |name, wins| result = name if wins >= 5 }
  result
end

loop do
  score = { 'Player' => 0, 'Computer' => 0 }

  loop do
    board = initalize_board

    loop do
      display_board(board)

      player_places_piece!(board)
      break if someone_won?(board) || board_full?(board)

      computer_places_piece!(board)
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
