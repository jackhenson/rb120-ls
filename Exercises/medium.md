1. Consider the following class:

```ruby
class Machine
  attr_writer :switch

  def start
    self.flip_switch(:on)
  end

  def stop
    self.flip_switch(:off)
  end

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end
```

Modify this class so both `flip_switch` and the setter method `switch=` are private methods.

A:

```ruby
class Machine
  def start
    self.flip_switch(:on)
  end

  def stop
    self.flip_switch(:off)
  end
    
  private

  attr_writer :switch
    
  def flip_switch(desired_state)
    self.switch = desired_state
  end
end
```



2. A fixed-length array is an array that always has a fixed number of  elements. Write a class that implements a fixed-length array, and  provides the necessary methods to support the following code:

```ruby
fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end
```

The above code should output `true` 16 times.

A:

```ruby
class FixedArray
  def initialize(arr_size)
    @arr = Array.new(arr_size)
  end

  def to_a
    @arr.clone
  end

  def to_s
    @arr.to_s
  end
   
  def [](idx)
    @arr.fetch(idx)
  end

  def []=(idx, value)
    self[idx]
    @arr[idx] = value
  end
end
```



3. Below we have 3 classes: `Student`, `Graduate`, and `Undergraduate`. The implementation details for the `#initialize` methods in `Graduate` and `Undergraduate` are missing. Fill in those missing details so that the following requirements are fulfilled:
   1. Graduate students have the option to use on-campus parking, while Undergraduate students do not.
   2. Graduate and Undergraduate students both have a name and year associated with them.

```ruby
class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
  end
end

class Undergraduate < Student
  def initialize(name, year)
  end
end
```

A:
```ruby
class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
# can delete this initialize method
  # def initialize(name, year)
  #   super
  # end
end
```



4. A circular queue is a collection of objects stored in a buffer that is treated as though it is connected end-to-end in a circle. 

Your task is to write a CircularQueue class that implements a  circular queue for arbitrary objects. The class should obtain the buffer size with an argument provided to `CircularQueue::new`, and should provide the following methods:

-   `enqueue` to add an object to the queue
-   `dequeue` to remove (and return) the oldest object in the queue. It should return `nil` if the queue is empty.

You may assume that none of the values stored in the queue are `nil` (however, `nil` may be used to designate empty spots in the buffer).

Examples:

```ruby
queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
```

The above code should display `true` 15 times.

A:

```ruby
class CircularQueue
  attr_accessor :queue, :current_index, :oldest_index

  def initialize(size)
    @queue = Array.new(size)
    @current_index = 0
    @oldest_index = 0
  end

  def queue_full?
    queue.none? { |v| v == nil }
  end
  
  def enqueue(value)
    dequeue if queue_full?
    self[current_index] = value
    update_current_index
  end
  
  def dequeue
    removed_value = queue.delete_at(oldest_index)
    queue.insert(oldest_index, nil)
    update_oldest_index unless removed_value == nil
    removed_value
  end

  def [](index)
    queue[index]
  end

  def []=(index, value)
    queue[index] = value
  end

  def update_current_index
    current_index >= (queue.size - 1) ? self.current_index = 0 : self.current_index += 1
  end

  def update_oldest_index
    oldest_index >= (queue.size - 1) ? self.oldest_index = 0 : self.oldest_index += 1
  end
end
```

Further Exploration:

```ruby
class CircularQueue
  attr_reader :size, :new_queue

  def initialize(size)
    @new_queue = Array.new
    @size = size 
  end

  def dequeue
    new_queue.shift 
  end

  def enqueue(element)
    dequeue if new_queue.count == size
    new_queue << element
  end
end
```



6. Create an object-oriented number guessing class for numbers in the range 1 to 100, with a limit of 7 guesses per game. The game should play like this:

```ruby
game = GuessingGame.new
game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
That's the number!

You won!

game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 50
Your guess is too high.

You have 6 guesses remaining.
Enter a number between 1 and 100: 25
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 37
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 31
Your guess is too low.

You have 3 guesses remaining.
Enter a number between 1 and 100: 34
Your guess is too high.

You have 2 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have 1 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have no more guesses. You lost!
```

A:

```ruby
class GuessingGame
  MAX_GUESSES = 7
  RANGE = 1..100

  RESULT_OF_GUESS_MESSAGE = {
    high:  "Your number is too high.",
    low:   "Your number is too low.",
    match: "That's the number!"
  }.freeze

  WIN_OR_LOSE = {
    high:  :lose,
    low:   :lose,
    match: :win
  }.freeze

  RESULT_OF_GAME_MESSAGE = {
    win:  "You won!",
    lose: "You have no more guesses. You lost!"
  }.freeze

  def initialize
    @secret_number = nil
  end

  def play
    reset
    game_result = play_game
    display_game_end_message(game_result)
  end

  private

  def reset
    @secret_number = rand(RANGE)
  end

  def play_game
    result = nil
    MAX_GUESSES.downto(1) do |remaining_guesses|
      display_guesses_remaining(remaining_guesses)
      result = check_guess(obtain_one_guess)
      puts RESULT_OF_GUESS_MESSAGE[result]
      break if result == :match
    end
    WIN_OR_LOSE[result]
  end

  def display_guesses_remaining(remaining)
    puts
    if remaining == 1
      puts 'You have 1 guess remaining.'
    else
      puts "You have #{remaining} guesses remaining."
    end
  end

  def obtain_one_guess
    loop do
      print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
      guess = gets.chomp.to_i
      return guess if RANGE.cover?(guess)
      print "Invalid guess. "
    end
  end

  def check_guess(guess_value)
    return :match if guess_value == @secret_number
    return :low if guess_value < @secret_number
    :high
  end

  def display_game_end_message(result)
    puts "", RESULT_OF_GAME_MESSAGE[result]
  end
end
```



7. In the previous exercise, you wrote a number guessing game that  determines a secret number between 1 and 100, and gives the user 7  opportunities to guess the number.

   Update your solution to accept a low and high value when you create a `GuessingGame` object, and use those values to compute a secret number for the game.  You should also change the number of guesses allowed so the user can  always win if she uses a good strategy. You can compute the number of  guesses with:

   ```ruby
   Math.log2(size_of_range).to_i + 1
   ```

   Examples:

   ```ruby
   game = GuessingGame.new(501, 1500)
   game.play
   
   You have 10 guesses remaining.
   Enter a number between 501 and 1500: 104
   Invalid guess. Enter a number between 501 and 1500: 1000
   Your guess is too low.
   
   You have 9 guesses remaining.
   Enter a number between 501 and 1500: 1250
   Your guess is too low.
   
   You have 8 guesses remaining.
   Enter a number between 501 and 1500: 1375
   Your guess is too high.
   
   You have 7 guesses remaining.
   Enter a number between 501 and 1500: 80
   Invalid guess. Enter a number between 501 and 1500: 1312
   Your guess is too low.
   
   You have 6 guesses remaining.
   Enter a number between 501 and 1500: 1343
   Your guess is too low.
   
   You have 5 guesses remaining.
   Enter a number between 501 and 1500: 1359
   Your guess is too high.
   
   You have 4 guesses remaining.
   Enter a number between 501 and 1500: 1351
   Your guess is too high.
   
   You have 3 guesses remaining.
   Enter a number between 501 and 1500: 1355
   That's the number!
   
   You won!
   
   game.play
   You have 10 guesses remaining.
   Enter a number between 501 and 1500: 1000
   Your guess is too high.
   
   You have 9 guesses remaining.
   Enter a number between 501 and 1500: 750
   Your guess is too low.
   
   You have 8 guesses remaining.
   Enter a number between 501 and 1500: 875
   Your guess is too high.
   
   You have 7 guesses remaining.
   Enter a number between 501 and 1500: 812
   Your guess is too low.
   
   You have 6 guesses remaining.
   Enter a number between 501 and 1500: 843
   Your guess is too high.
   
   You have 5 guesses remaining.
   Enter a number between 501 and 1500: 820
   Your guess is too low.
   
   You have 4 guesses remaining.
   Enter a number between 501 and 1500: 830
   Your guess is too low.
   
   You have 3 guesses remaining.
   Enter a number between 501 and 1500: 835
   Your guess is too low.
   
   You have 2 guesses remaining.
   Enter a number between 501 and 1500: 836
   Your guess is too low.
   
   You have 1 guesses remaining.
   Enter a number between 501 and 1500: 837
   Your guess is too low.
   
   You have no more guesses. You lost!
   ```

   Note that a game object should start a new game with a new number to guess with each call to `#play`.

A:

