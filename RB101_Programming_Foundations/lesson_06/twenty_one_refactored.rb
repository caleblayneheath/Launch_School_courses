require 'pry'
require 'pry-byebug'

SUITS = %w(C D H S)
CARD_VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
                '8' => 8, '9' => 9, '10' => 10, 'J' => 10, 'Q' => 10,
                'K' => 10, 'A' => 11 }

STARTING_DECK = SUITS.flat_map do |suit|
  cards = []
  CARD_VALUES.to_a.each { |string, number| cards << [suit, string, number] }
  cards
end

PLAYER_NAME = 'player'
DEALER_NAME = 'dealer'

DEALER_GOAL = 17
GOAL_NUMBER = 21
ROUNDS_TO_WIN = 5

def prompt(string)
  puts "=> #{string}"
end

def initialize_deck
  STARTING_DECK.dup.shuffle
end

def initialize_player
  { cards: [], total: 0, busted: nil }
end

def deal_cards(hand, deck, number = 1)
  number.times { hand << deck.pop }
end

def evalute_hand(player)
  player[:total] = player[:cards].sum(&:last)

  if aces?(player[:cards])
    correct_aces(player)
  end
end

def aces?(hand)
  !!hand.rassoc('A')
end

def correct_aces(player)
  if (player[:total]) > GOAL_NUMBER
    player[:cards].each do |card|
      if card[1] == ('A')
        card[-1] = 1
        player[:total] = player[:cards].sum(&:last)
      end
      break if player[:total] <= GOAL_NUMBER
    end
  end
end

def show_hands(player_hand, dealer_hand)
  prompt("Dealer has: #{format_cards(dealer_hand, 'hide')}")
  prompt("You have: #{format_cards(player_hand)}.")
end

def show_player_total(total)
  prompt("Your total is #{total}.")
end

def format_cards(cards, hide = nil)
  show = cards.map { |_, value, _| value }
  if hide == 'hide'
    show[0] = 'Unknown card'
  end
  show.join(', ')
end

def busted?(total)
  total > GOAL_NUMBER
end

def make_busted(player)
  player[:busted] = true
end

def compare_totals(player, dealer)
  return DEALER_NAME if player[:total] < dealer[:total]
  PLAYER_NAME
end

def invalid_choice
  prompt 'Invalid selection.'
end

def initial_deal(player, dealer, deck)
  deal_cards(player[:cards], deck, 2)
  deal_cards(dealer[:cards], deck, 2)

  evalute_hand(player)
  evalute_hand(dealer)

  show_hands(player[:cards], dealer[:cards])
  show_player_total(player[:total])
end

# get input, check validity, ends turn if staying
# otherwise deal and score cards, show hands, check if player busted
def player_turn(player, dealer, deck)
  loop do
    choice = player_input
    break if choice == 's'

    deal_cards(player[:cards], deck)
    evalute_hand(player)
    show_hands(player[:cards], dealer[:cards])
    show_player_total(player[:total])

    if busted?(player[:total])
      make_busted(player)
      prompt("You busted!")
      break
    end
  end
end

def player_input
  choice = nil
  loop do
    prompt("Enter 'd' to draw a card, or 's' to stay")
    choice = gets.chomp.downcase
    break if ['d', 's'].include?(choice)
    invalid_choice
  end
  choice
end

def dealer_turn(player, dealer, deck)
  loop do
    if dealer[:total] <= DEALER_GOAL
      deal_cards(dealer[:cards], deck)
      evalute_hand(dealer)
      show_hands(player[:cards], dealer[:cards])
      if busted?(dealer[:total])
        make_busted(dealer)
        prompt("Dealer busted!")
        break
      end
    else
      prompt 'Dealer stays.'
      break
    end
    sleep 1
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
  answer == 'y'
end

def goodbye
  prompt("Thanks for playing! Goodbye.")
end

def display_winner(winner)
  prompt("The winner is #{winner}.")
end

def get_overall_winner(score_hsh)
  result = nil
  score_hsh.each { |name, wins| result = name if wins >= ROUNDS_TO_WIN }
  result
end

def display_overall_winner(overall_winner)
  prompt("#{overall_winner} won the game!") if overall_winner
end

def update_score(score, winner)
  score[winner] += 1
end

def display_score(score)
  prompt "Player wins: #{score[PLAYER_NAME]}"
  prompt "Dealer wins: #{score[DEALER_NAME]}"
end

loop do
  score = { PLAYER_NAME => 0, DEALER_NAME => 0 }
  loop do
    puts
    prompt 'Starting new round.'

    game_deck = initialize_deck
    winner = nil

    player = initialize_player
    dealer = initialize_player

    initial_deal(player, dealer, game_deck)

    player_turn(player, dealer, game_deck)
    winner = DEALER_NAME if player[:busted]

    dealer_turn(player, dealer, game_deck) unless winner == DEALER_NAME
    winner = PLAYER_NAME if dealer[:busted]

    winner = compare_totals(player, dealer) if winner.nil?

    display_winner(winner)

    update_score(score, winner)
    display_score(score)

    overall_winner = get_overall_winner(score)
    display_overall_winner(overall_winner)
    break if !!overall_winner
  end

  break unless play_again?
end
goodbye
