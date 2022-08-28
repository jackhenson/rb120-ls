require 'yaml'
RULES = YAML.load_file('twentyone.yml')

MATCH_SCORE_TO_WIN = 3
WIN_SCORE = 21

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
    The first player to win 3 games wins the match. Good luck!

    MSG
  end

  def display_goodbye_message
    clear
    puts "Thanks for playing! Goodbye."
  end

  def display_new_game_message
    puts "  Preparing new game"
    sleep 0.5
    clear
    puts " ~Preparing new game~"
    sleep 0.5
    clear
    puts "~~Preparing new game~~"
    sleep 0.5
    clear
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
    puts RULES['overview']
  end

  def display_scoring_rules
    puts RULES['scoring']
  end

  def display_game_overview
    clear
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
    sleep 0.5
    clear
  end

  def display_one_card_deal_human
    clear
    print "Dealing you one card."
    sleep 0.5
    print "."
    sleep 0.5
    print "."
    sleep 0.5
    clear
  end

  def display_one_card_deal_dealer
    clear
    print "#{dealer.name} deals one card to themselves."
    sleep 0.5
    print "."
    sleep 0.5
    print "."
    sleep 0.5
    clear
  end

  # joins multiple card values for display
  def joinor(arr, deliminator=', ', word='and')
    case arr.size
    when 0 then ''
    when 1 then arr.first
    when 2 then arr.join(" #{word} ")
    else
      arr.append("#{word} #{arr.pop}")
      arr.join(deliminator)
    end
  end
end

class Deck
  CARD_VALUES = ['2', '3', '4', '5', '6', '7', '8',
                 '9', '10', 'J', 'Q', 'K', 'A']

  CARD_SUITES = ['H', 'D', 'S', 'C']

  def initialize
    @cards = []
    add_cards
  end

  def shuffle
    self.cards = cards.shuffle
  end

  def draw_random_card
    cards.pop
  end

  def reset
    cards.clear
    add_cards
  end

  private

  attr_accessor :cards

  # array of all possible card names
  # each card name formatted [value, suite]
  def card_names
    names = []
    CARD_VALUES.each do |v|
      CARD_SUITES.each do |s|
        names << [v, s]
      end
    end
    names
  end

  def add_cards
    card_names.each { |n| cards << Card.new(n) }
  end
end

class Card
  # card names are formatted [value, suite]
  def initialize(card_name)
    @value = card_name[0]
    @suite = card_name[1]
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
    value
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

  attr_reader :name, :hand

  def initialize
    @hand = []
    set_name
  end

  def display_hand
    puts joinor(hand.map(&:value))
  end

  def hand_score
    score = hand.map(&:point_value).sum
    # special ace scoring rules
    hand.select { |c| c.value == 'Ace' }.count.times do
      score -= 10 if score > WIN_SCORE
    end

    score
  end

  def bust?
    hand_score > WIN_SCORE
  end

  def reset
    hand.clear
  end

  private

  attr_writer :name
end

class Human < Player
  def hit?
    answer = nil
    loop do
      prompt "Would you like to hit (h) or stay (s)?"
      answer = gets.chomp.downcase
      break if ['h', 's'].include? answer
      puts "Invalid. Please enter 'h' to hit, or 's' to stay."
    end

    answer == 'h'
  end

  private

  def set_name
    clear
    loop do
      prompt "What is your name?"
      self.name = gets.chomp
      break if name.match?(/[a-zA-Z0-9]/)
      puts "Please enter a valid name."
    end
  end
end

class Dealer < Player
  def display_partial_hand
    puts "#{hand[0]} and hidden card"
  end

  def hit?(human_score)
    hand_score < 17 || hand_score < human_score
  end

  private

  def set_name
    self.name = ['007', 'Adam', 'Dom', 'Lawton'].sample
  end
end

class Scoreboard
  attr_reader :human_match_score, :dealer_match_score, :ties

  def initialize
    @human_match_score = 0
    @dealer_match_score = 0
    @ties = 0
  end

  def display(dealers_name)
    puts "--- Current Match Score ---"
    puts "You: #{human_match_score} game(s) won."
    puts "#{dealers_name}: #{dealer_match_score} game(s) won."
    puts "Ties: #{ties}"
    puts
  end

  def increase_human_score
    self.human_match_score += 1
  end

  def increase_dealer_score
    self.dealer_match_score += 1
  end

  def increase_tie_score
    self.ties += 1
  end

  def someone_won_match?
    @human_match_score >= MATCH_SCORE_TO_WIN ||
      @dealer_match_score >= MATCH_SCORE_TO_WIN
  end

  def reset
    @human_match_score = 0
    @dealer_match_score = 0
    @ties = 0
  end

  private

  attr_writer :human_match_score, :dealer_match_score, :ties
end

# orchestration engine
class Game
  include Displayable

  attr_reader :deck, :human, :dealer, :scoreboard

  def initialize
    @deck = Deck.new
    @human = Human.new
    @dealer = Dealer.new
    @scoreboard = Scoreboard.new
  end

  def play
    greeting
    loop do
      clear
      play_one_match
      display_match_winner
      play_again? ? reset_scores : break
    end
    display_goodbye_message
  end

  private

  # game play

  def play_one_match
    loop do
      play_one_game
      break if scoreboard.someone_won_match?
    end
  end

  def play_one_game
    display_new_game_message
    initial_deal
    show_hands_dealer_hidden
    player_turn
    dealer_turn unless human.bust?
    show_result
    update_score
    scoreboard.display(dealer.name)
    reset
    prompt_clear
  end

  # player turns

  def player_turn
    loop do
      puts "Your current total hand score is: #{human.hand_score}."
      human.hit? ? deal_card_to_player : return
      show_hands_dealer_hidden
      break if human.bust?
    end

    puts "Sorry, you busted!"
    prompt_clear
  end

  def dealer_turn
    clear
    puts "#{dealer.name}'s turn!"
    while dealer.hit?(human.hand_score)
      deal_card_to_dealer
      show_hands
      display_hand_scores
      puts "#{dealer.name} busted!" if dealer.bust?
      prompt_clear
    end
  end

  # display

  def greeting
    clear
    display_welcome_message
    display_game_overview if display_rules?
  end

  def show_hands_dealer_hidden
    puts "Your hand:"
    human.display_hand
    puts
    puts "#{dealer.name}'s hand (1 card hidden):"
    dealer.display_partial_hand
    puts
  end

  def show_hands
    puts "Your hand:"
    human.display_hand
    puts
    puts "#{dealer.name}'s hand:"
    dealer.display_hand
    puts
  end

  def display_hand_scores
    puts "---Hand scores---"
    puts "Your hand total: #{human.hand_score}"
    puts "#{dealer.name}'s hand total: #{dealer.hand_score}"
    puts
  end

  def show_result
    puts "This game is over!"
    puts
    show_hands
    display_hand_scores
    display_game_winner
    puts
    prompt_clear
  end

  def display_game_winner
    if human_won_game?
      puts "You've won this game!"
    elsif dealer_won_game?
      puts "#{dealer.name} won this game!"
    elsif tie_game?
      puts "It's a tie!"
    end
  end

  def display_match_winner
    if scoreboard.human_match_score >= MATCH_SCORE_TO_WIN
      puts "You've won the match! Congratulations!"
    else
      puts "#{dealer.name} has won the match. Better luck next time!"
    end
  end

  def play_again?
    puts
    answer = nil
    loop do
      prompt "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'yes', 'n', 'no'].include? answer
      puts "Sorry, invalid response. Please answer 'y' or 'n'."
    end

    answer == 'y' || answer == 'yes'
  end

  # winning logic and scoring

  def human_won_game?
    (human.hand_score > dealer.hand_score && human.hand_score <= WIN_SCORE) ||
      (human.hand_score <= WIN_SCORE && dealer.bust?)
  end

  def dealer_won_game?
    (dealer.hand_score > human.hand_score && dealer.hand_score <= WIN_SCORE) ||
      (human.bust?)
  end

  def tie_game?
    human.hand_score == dealer.hand_score
  end

  def update_score
    if human_won_game?
      scoreboard.increase_human_score
    elsif dealer_won_game?
      scoreboard.increase_dealer_score
    elsif tie_game?
      scoreboard.increase_tie_score
    end
  end

  # dealing

  def initial_deal
    deck.shuffle
    display_dealing_message
    2.times { human.hand << deck.draw_random_card }
    2.times { dealer.hand << deck.draw_random_card }
  end

  def deal_card_to_player
    display_one_card_deal_human
    human.hand << deck.draw_random_card
  end

  def deal_card_to_dealer
    display_one_card_deal_dealer
    dealer.hand << deck.draw_random_card
  end

  # game reset

  def reset
    deck.reset
    human.reset
    dealer.reset
  end

  def reset_scores
    clear
    scoreboard.reset
  end
end

Game.new.play
