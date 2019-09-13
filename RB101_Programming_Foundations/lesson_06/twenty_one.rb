require 'pry'
require 'pry-byebug'

# STARTING_DECK = %w(2 3 4 5 6 7 8 9 10 J Q K A) * 4
VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)
SUITS = %w(C D H S)

CARD_VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
                '8' => 8, '9' => 9, '10' => 10, 'J' => 10, 'Q' => 10,
                'K' => 10, 'A' => 11 }

# for cards of [suit, string_value]
# STARTING_DECK = VALUES.map do
#   |value| SUITS.zip([value] * SUITS.size)
# end.flatten(1)

# for cards of [suit, string_value, point_value]
# STARTING_DECK = SUITS.map do |suit|
#   cards = []
#   CARD_VALUES.to_a.each { |string, number| cards << [suit, string, number] }
#   cards
# end.flatten(1)

STARTING_DECK = SUITS.flat_map do |suit|
  cards = []
  CARD_VALUES.to_a.each { |string, number| cards << [suit, string, number] }
  cards
end

def prompt(string)
  puts "=> #{string}"
end

def initialize_deck
  STARTING_DECK.dup.shuffle
end

def initialize_player
  { cards: [], score: 0 }
end

def deal_cards(player, deck, number = 1)
  number.times do
    dealt_card = deck.pop
    player[:cards] << dealt_card
    score_hand(player)
    if !!player[:cards].rassoc('A')
      assign_ace_value(player)
    end
  end
end

def assign_ace_value(player)
  if (player[:score]) > 21
    player[:cards].each do |card|
      if card[-1] == 11
        card[-1] = 1
        score_hand(player)
      end
      break if player[:score] <= 21
    end
  end
end

def initial_deal(player, dealer, deck)
  deal_cards(player, deck, 2)
  deal_cards(dealer, deck, 2)
end

def score_hand(player)
  player[:score] = player[:cards].sum(&:last)
end

def show_hands(player, dealer)
  prompt("Dealer has: #{format_cards(dealer[:cards], 'hide')}")
  prompt("You have: #{format_cards(player[:cards])}")
end

def format_cards(cards, hide = nil)
  show = cards.map { |_, value, _| value }.join(', ')
  if hide == 'hide'
    show[0] = 'Unknown card'
  end
  show
end

def busted?(player)
  score_hand(player) > 21
end

def compare_scores(player, dealer)
  return 'dealer' if player[:score] < dealer[:score]
  'player'
end

game_deck = initialize_deck
winner = nil
player = initialize_player
dealer = initialize_player

initial_deal(player, dealer, game_deck)
show_hands(player, dealer)

# player turn
loop do
  prompt("Enter 'd' to draw a card, or 's' to stay")
  choice = gets.chomp

  if choice == 'd'
    deal_cards(player, game_deck)
    show_hands(player, dealer)
  end

  if choice == 's'
    break
  end

  if busted?(player)
    winner = 'dealer'
    prompt("You busted!")
    break
  end
end

# dealer turn
unless winner == 'dealer'
  loop do
    if dealer[:score] <= 17
      deal_cards(dealer, game_deck)
      show_hands(player, dealer)
    else
      break
    end

    if busted?(dealer)
      winner = 'player'
      prompt("Dealer busted!")
    end
  end
end

if winner.nil?
  winner = compare_scores(player, dealer)
end

prompt("The winner is #{winner}.")
