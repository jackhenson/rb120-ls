1. You are given the following code:

```ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end
```

What is the result of executing the following code:

```ruby
oracle = Oracle.new
oracle.predict_the_future
```

A:
Each time you call, a string is returned which will be of the form `"You will <something>"`, where the something is one of the 3 phrases defined in the array returned by the `choices` method.  The specific string will be chosen randomly.



2. We have an `Oracle` class and a `RoadTrip` class that inherits from the `Oracle` class.

```ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end
```

What is the result of the following:

```ruby
trip = RoadTrip.new
trip.predict_the_future
```

A:

Now the string returned will be of the form `"You will <some trip>"` where the trip is taken from the choices defined by the `choices` method of `RoadTrip`.

Since we're calling `predict_the_future` on an instance of `RoadTrip`, every time Ruby tries to resolve a method name, it will start with the  methods defined on the class you are calling.  So even though the call  to `choices` happens in a method defined in `Oracle`, Ruby will first look for a definition of `choices` in `RoadTrip` before falling back to `Oracle` if it does not find `choices` defined in `RoadTrip`.



3. How do you find where Ruby will look for a method when that method is called? How can you find an object's ancestors?

```ruby
module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end
```

What is the lookup chain for `Orange` and `HotSauce`?

A:

The lookup chain is

```
Orange or HotSauce
Taste
Object
Kernel
BasicObject
```



4. What could you add to this class to simplify it and remove two methods  from the class definition while still maintaining the same  functionality?

```ruby
class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end
```

A:

You can add `attr_accessor :type`.



5. There are a number of variables listed below. What are the different types and how do you know which is which?

```ruby
excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"
```

A:

```ruby
excited_dog = "excited dog"  # local variable
@excited_dog = "excited dog" # instance variable
@@excited_dog = "excited dog" # class variable
```



6. If I have the following class:

```ruby
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
```

Which one of these is a class method (if any) and how do you know? How would you call a class method?

A:

`manufacturer` is a class method. This is evident by the use of `self` in the method definition. A class method is called on the class itself.



7. If we have a class such as the one below:

```ruby
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end
```

Explain what the `@@cats_count` variable does and how it works. What code would you need to write to test your theory?

A:

`@@cats_count` is a class variable, shared by all instances of the class. Each time a new `Cat` object is instantiated, `@@cats_count` is incremented by 1. Calling `Cat.cats_count` will return the total number of `Cat` objects instantiated.



8. If we have this class:

```ruby
class Game
  def play
    "Start the game!"
  end
end
```

And another class:

```ruby
class Bingo
  def rules_of_play
    #rules of play
  end
end
```

What can we add to the `Bingo` class to allow it to inherit the `play` method from the `Game` class?

A:

`class Bingo < Game`



9. If we have this class:

```ruby
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end
```

What would happen if we added a `play` method to the `Bingo` class, keeping in mind that there is already a method of this name in the `Game` class that the `Bingo` class inherits from.

A:

Since the `Bingo` class is a subclass of the `Game` class, defining a new `play` method in the `Bingo` class definition would override the `Game`'s `play` method.



10. What are the benefits of using Object Oriented Programming in Ruby? Think of as many as you can.

A:

- Structure and organiziation
- Allows programmers to think abstractly
- Allows programs to model real world problems
- Allows us to selectively expose functionality through the public interface using access modifiers
- Build applications faster by reusing code through inheritance