module Displayable
  def prompt(msg)
    puts ">> #{msg}"
  end

  def clear
    system 'clear'
  end

  def prompt_clear
    prompt "Press Enter to continue."
    gets.chomp
    system 'clear'
  end

  def display_welcome_message
    puts <<-MSG
    Welcome to Twenty One, #{human.name}!
    In this game, you'll be playing against the dealer, #{dealer.name}.

    MSG
  end

  def display_rules?
    answer = nil
    loop do
      prompt "Would you like to view the rules and scoring? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n', 'yes', 'no'].include? answer
      puts "Invalid response. Please enter 'y' or 'n'."
    end

    answer == 'y' || answer == 'yes'
  end

  def display_rules
    puts <<-MSG
    Twenty-One is a card game consisting of a dealer and a player, where the 
    participants try to get as close to 21 as possible without going over.

    Here is an overview of the game:
    - Both participants are initially dealt 2 cards from a 52-card deck.
    - The player takes the first turn, and can "hit" or "stay".
    - If the player busts, he loses. If he stays, it's the dealer's turn.
    - The dealer must hit until his cards add up to at least 17.
    - If he busts, the player wins. If both player and dealer stays, then the 
      highest total wins.
    - If both totals are equal, then it's a tie, and nobody wins.
    MSG
  end

  def display_scoring_rules
    puts <<-MSG
    All of the card values are pretty straightforward, except for the ace. 
    Numbers 2 through 10 are worth their face value. 
    The jack, queen, and king are each worth 10.
    The ace can be worth 1 or 11. 

    Ace scoring rules:
    The ace's value is determined each time a new card is drawn from the deck.
    If the sum of the hand doesn't exceed 21, the Ace is worth 11.
    If the sum of the hand exceeds 21, the Ace is worth 1.
    MSG
  end

  def display_game_overview
    display_rules
    prompt_clear
    display_scoring_rules
    prompt_clear
  end

  def display_dealing_message
    clear
    print "Dealing two cards to each player."
    sleep 0.5
    print "."
    sleep 0.5
    print "."
    puts
  end
end

class Deck
  attr_accessor :cards

  CARD_VALUES = ['2', '3', '4', '5', '6', '7',
    '8', '9', '10', 'J', 'Q', 'K', 'A']

  CARD_SUITES = ['H', 'D', 'S', 'C']

  def initialize
    @cards = []
    add_cards
  end

  def add_cards
    card_names.each { |n| cards << Card.new(n) }
  end

  # def to_s
  #   puts @cards
  # end

  def card_names
    names = []
    CARD_VALUES.each do |n|
      CARD_SUITES.each do |s|
        names << n+s
      end
    end
    names
  end

  def shuffle
    self.cards = cards.shuffle
  end

  def draw_random_card
    cards.pop
  end
end

class Card
  def initialize(type)
    @value = type[0]
    @suite = type[1]
  end

  def value
    case @value
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    when 'A' then 'Ace'
    else @value
    end
  end

  def suite
    case @suite
    when 'D' then 'Diamonds'
    when 'C' then 'Clubs'
    when 'H' then 'Hearts'
    when 'S' then 'Spades'
    end
  end

  def to_s
    "#{value} of #{suite}"
  end

  def point_value
    if (2..10).include? @value.to_i
      value.to_i
    elsif ['J', 'Q', 'K'].include? @value
      10
    else
      11
    end
  end
end

class Player
  include Displayable

  attr_accessor :name, :hand

  def initialize
    @hand = []
    set_name
  end

  def display_hand
    puts hand
  end
end

class Human < Player
  def set_name
    loop do
      prompt "What is your name?"
      self.name = gets.chomp
      break unless name.empty?
      puts "Please enter a valid name."
    end
  end
end

class Dealer < Player
  def set_name
    self.name = ['007', 'Adam', 'Dom', 'Lawton'].sample
  end

  def display_partial_hand
    puts hand[0]
  end
end

# orchestration engine
class Game
  include Displayable

  attr_accessor :deck, :human, :dealer

  def initialize
    @deck = Deck.new
    @human = Human.new
    @dealer = Dealer.new
  end

  def play
    greeting
    deal_cards
    show_initial_cards
    # player_turn
    # dealer_turn
    # show_result
  end

  private

  def show_initial_cards
    puts "Your hand:"
    human.display_hand
    puts
    puts "Dealer's hand (1 card hidden):"
    dealer.display_partial_hand
  end

  def greeting
    clear
    display_welcome_message
    display_game_overview if display_rules?
  end

  def deal_cards
    display_dealing_message
    deck.shuffle
    human.hand << deck.draw_random_card
    human.hand << deck.draw_random_card
    dealer.hand << deck.draw_random_card
    dealer.hand << deck.draw_random_card
  end
end

game = Game.new.play
