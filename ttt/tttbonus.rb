module Displayable
  def clear
    system 'clear'
  end

  def prompt_clear
    prompt "Press any key to continue."
    gets.chomp
    system 'clear'
  end

  def prompt(msg)
    puts ">> #{msg}"
  end
end

module Constants
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  COUNT_TO_WIN = 5
  COMPUTER_NAMES = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']
end

class Board
  def initialize
    @squares = {}
    reset
  end

  def [](key)
    @squares[key]
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |k| @squares[k].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # returns winning marker or nil
  def winning_marker
    Constants::WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def find_opportunity_lines
    opp_lines = []
    Constants::WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      opp_lines << line if two_identical_markers?(squares)
    end

    opp_lines.empty? ? nil : opp_lines
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def two_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 2
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  include Displayable

  attr_reader :marker, :score, :name

  def initialize
    @score = 0
    set_name
  end

  def win_match?
    score >= Constants::COUNT_TO_WIN
  end

  def increase_score
    self.score += 1
  end

  def reset_score
    self.score = 0
  end

  private

  attr_writer :marker, :score, :name
end

class Human < Player
  def set_marker
    loop do
      prompt "Choose your marker: X or O."
      self.marker = gets.chomp.upcase
      break if ['X', 'O'].include? marker
      puts "Please choose either X or O."
    end
  end

  private

  def set_name
    loop do
      prompt "What is your name?"
      self.name = gets.chomp
      break unless name.empty?
      puts "Please enter a valid name."
    end
  end
end

class Computer < Player
  attr_writer :marker

  private

  def set_name
    self.name = Constants::COMPUTER_NAMES.sample
  end
end

class TTTGame
  include Displayable

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
  end

  def play
    display_welcome_message
    loop do
      set_markers
      self.current_marker = set_first_player
      clear
      play_one_match
      display_match_winner
      play_again? ? clear_screen_and_reset_scores : break
    end
    display_goodbye_message
  end

  private

  attr_accessor :first_player, :current_marker

  def someone_won_match?
    human.win_match? || computer.win_match?
  end

  def play_one_match
    loop do
      play_one_round
      break if someone_won_match?
    end
  end

  def play_one_round
    display_board
    player_move
    display_round_winner
    prompt_clear
    update_score
    display_score
    prompt_clear
    reset
  end

  def set_markers
    human.set_marker
    computer.marker = if human.marker == 'X'
                        'O'
                      else
                        'X'
                      end
    clear
  end

  def set_first_player
    answer = nil
    loop do
      prompt "Who should play first?"
      prompt "Enter 'me' or 'computer':"
      answer = gets.chomp.downcase
      break if ['me', 'computer'].include? answer
      puts "Invalid choice. Please enter 'me' or 'computer'."
    end

    self.first_player = answer == 'me' ? human.marker : computer.marker
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board
    end
  end

  def display_welcome_message
    clear
    puts "Welcome to Tic Tac Toe, #{human.name}!"
    puts "In this match, you'll be facing #{computer.name}, the computer."
    puts "First to win #{Constants::COUNT_TO_WIN} rounds wins the match!"
    puts
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts
    board.draw
    puts
  end

  def joinor(arr, deliminator=', ', word='or')
    case arr.size
    when 0 then ''
    when 1 then arr.first
    when 2 then arr.join(" #{word} ")
    else
      arr.append("#{word} #{arr.pop}")
      arr.join(deliminator)
    end
  end

  def human_moves
    puts "Choose a square: (#{joinor(board.unmarked_keys)})"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    square = if computer_offense_move
               computer_offense_move
             elsif computer_defense_move
               computer_defense_move
             elsif board[5].unmarked?
               5
             else
               board.unmarked_keys.sample
             end

    board[square] = computer.marker
  end

  def computer_offense_move
    opp_lines = board.find_opportunity_lines
    return nil if opp_lines.nil?
    opp_lines.each do |line|
      if line.any? { |s| board[s].marker == computer.marker }
        line.each { |s| return s if board[s].unmarked? }
      end
    end
    nil
  end

  def computer_defense_move
    opp_lines = board.find_opportunity_lines
    return nil if opp_lines.nil?
    opp_lines.each do |line|
      if line.any? { |s| board[s].marker == human.marker }
        line.each { |s| return s if board[s].unmarked? }
      end
    end
    nil
  end

  def display_round_winner
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won."
    else
      puts "It's a tie!"
    end
  end

  def display_match_winner
    if human.win_match?
      puts "Congratulations! You've won the match!"
    else
      puts "Sorry! #{computer.name} has won the match!"
    end
  end

  def update_score
    case board.winning_marker
    when human.marker
      human.increase_score
    when computer.marker
      computer.increase_score
    end
  end

  def display_score
    puts "-----Match Scoreboard-----"
    puts "#{human.name}: #{human.score}, #{computer.name}: #{computer.score}"
    puts
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def reset
    board.reset
    self.current_marker = first_player
  end

  def clear_screen_and_reset_scores
    clear
    human.reset_score
    computer.reset_score
  end

  def display_play_again_message
    puts "Let's play again!"
    puts
  end

  def human_turn?
    current_marker == human.marker
  end

  def current_player_moves
    if human_turn?
      human_moves
      self.current_marker = computer.marker
    else
      computer_moves
      self.current_marker = human.marker
    end
  end
end

game = TTTGame.new
game.play
