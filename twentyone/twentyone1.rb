class Deck
  attr_accessor :cards

  CARD_VALUES = ['2', '3', '4', '5', '6',
    '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  CARD_SUITES = ['H', 'D', 'S', 'C']

  def initialize
    @cards = []
    add_cards_to_deck
  end

  def add_cards_to_deck
    card_names.each { |n| cards << Card.new(n) }
  end

  def to_s
    puts @cards
  end

  def card_names
    names = []
    CARD_VALUES.each do |n|
      CARD_SUITES.each do |s|
        names << n+s
      end
    end
    names
  end

  def draw_random_card
    cards.sample
  end
end

class Card
  attr_reader :value

  def initialize(type)
    @value = type[0]
    @suite = type[1]
  end

  def to_s
    @value + @suite
  end

  def point_value
    if (2..10).include? value.to_i
      value.to_i
    elsif ['J', 'Q', 'K'].include? value
      10
    else
      11
    end
  end
end

class Player
end

class Human < Player
end

class Dealer < Player
end

# orchestration engine
class Game
  def initialize
    @deck = Deck.new
    @human = Human.new
    @dealer = Dealer.new
  end

  def play
    deal_initial_hand
    players_turn
    dealers_turn unless player_bust?
    display_result
  end
end

new_deck = Deck.new
puts new_deck.cards.size
