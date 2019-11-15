=begin
Twenty-One is a game.
It has two participants, a dealer and a player.
It is played with a 52 card deck (4 suits with values 2-10 and face cards)

Goal: Get the largest hand possible as long as its point value is at or under 21.

Game flow:
Dealer deals 2 cards to player and also to itself.
The 2 players cards are faceup. For the dealer cards, 1 is revealed to player and the other hidden.

The player's turn is first. They can then either hit or stay.
-If hit, draw a card.
  -If hand total goes over 21, the player busts and the dealer wins.
-If stay, dealer takes turn.

The dealer's turn is last. They can hit or stay.
-Dealer hits as long as total is not at least 17.
-If total is at least 17 but not over 21, dealer stays.
-If dealer busts, player automatically wins.

If neither play has busted, the winner is whoever has the highest valued hand. Ties are possible.

Hands are scored according to:
2-10 is 2-10, JQK are 10, A is either 1 or 11 (whatever is most advantageious)

Player
Dealer
  -deal (maybe)
Participant
  -hit
  -stay
  -busted?
  -total
Game
  -play
Deck
  -shuffle
  -deal (maybe)
Card
  -value
=end

module Hand
  def hit
  end

  def stay
  end

  def busted?
  end

  def total
  end
end

class Game
  def initialize
  end
  
  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end

class Player
  def initialize
    #states: hand (of cards), point total of hand, name?
    #busted or not
  end
end

class Dealer
  def initialize
    #states: hand (of cards), point total of hand, name?
    #busted or not
  end
end

class Deck
  def initialize
    #states: deck of cards (array of card objects/structs)
  end
  
  def deal
  end

  def shuffle
  end
end

class Card
  def initialize
    #states: suit, value, hidden?, (maybe point value)
  end

  def value
  end
end

Game.new.start