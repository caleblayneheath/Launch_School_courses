INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

def display_board(brd)
  system 'clear'
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

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square: #{empty_squares(brd).join(', ')}."
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + 
                  [[1, 4, 7] ,[2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  winning_lines.each do |line|
    line.all?(PLAYER_MARKER)
  end
end

board = initalize_board
display_board(board)

loop do
  player_places_piece!(board)
  computer_places_piece!(board)
  display_board(board)
  break if someone_won?(board) || board_full?(board)
end
  
if someone_won?(board)
  prompt "#{detect_winner(board)} won!"
else
  prompt "It's a tie!"
end
  
#   while true # game_status == unresolved

#   # display initial empty board

#   # have user mark square

#   # have computer mark square

#   # display updated board

#   # if winner display winner

#   # if board full, declare tie

#   # if neither winner nor full go back to step of user input

#   end

# # ask to play again

# # go to beginning if yes

# end
# # goodbye