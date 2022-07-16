class Player
  def initialize(player_type = :human)
    @player_type = player_type
  end

  def choose
    if human?

    else
      ['rock', 'paper', 'scissors'].sample
    end
  end

  def human?
    @player_type == :human
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer
  
  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
    puts "Snip-snip, plop-plop, ruffle-ruffle. Pick your poison!"
  end

  def display_goodbye_message
    puts "Thanks for playing! Goodbye!"
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end

class Move
  def initialize
  end
end

class Rule
  def initialize
  end
end

RPSGame.new.play