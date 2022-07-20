1. Behold this incomplete class for constructing boxed banners.

```ruby
class Banner
  def initialize(message)
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
  end

  def empty_line
  end

  def message_line
    "| #{@message} |"
  end
end
```

Complete this class so that the test cases shown below work as intended. You are free to add any methods or instance variables you need. However, do not make the implementation details public.

You may assume that the input will always fit in your terminal window.

Test Cases

```ruby
banner = Banner.new('To boldly go where no one has gone before.')
puts banner
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+
```

```ruby
banner = Banner.new('')
puts banner
+--+
|  |
|  |
|  |
+--+
```



A:

```ruby
class Banner
  def initialize(message)
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private
  
  def message_length
    message.size
  end

  def horizontal_rule
    "+-" + "-" * message_length + "-+"
  end

  def empty_line
    "| " + " " * message_length + " |"
  end

  def message_line
    "| #{@message} |"
  end
end
```



2. Take a look at the following code:

```ruby
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
```

What output does this code print? Fix this class so that there are no surprises waiting in store for the unsuspecting developer.

A:

```ruby
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.upcase
  end

  def to_s
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
```

The `String` object referenced by `@name` is not modified until `to_s` is called on the `Pet` object (since `String#to_s` is called in `initialize` , which returns `self`.)



3. Complete this program so that it produces the expected output:

```ruby
class Book
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
```

Expected output:

```ruby
The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.
```

A:

```ruby
class Book
  attr_reader :author, :title
  
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
```



4. Complete this program so that it produces the expected output:

```ruby
class Book
  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
```

Expected output:

```ruby
The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.
```

A:

```ruby
class Book
  attr_accessor :author, :title
  
  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
```



5. Complete this program so that it produces the expected output:

```ruby
class Person
  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
puts person
```

Expected output:

```ruby
John Doe
Jane Smith
```

A:

```ruby
class Person
  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
  
  def first_name= (value)
  	@first_name = value.capitalize
	end

	def last_name= (value)
 	 @last_name = value.capitalize
	end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
puts person
```



6. Consider the following class definition:

```ruby
class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end
```

There is nothing technically incorrect about this class, but the definition may lead to problems in the future. How can this class be fixed to be resistant to future problems?

A:

```ruby
class Flight
	def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end
```

Remove the unneeded `attr_accessor`.



7. Fix the following code so it works properly:

```ruby
class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    mileage = total
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678
```

A:

```ruby
class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678
```



8. Given the following class:

```ruby
class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end
```

Write a class called `Square` that inherits from Rectangle, and is used like this:

```ruby
square = Square.new(5)
puts "area of square = #{square.area}"
```

A:

```ruby
class Square < Rectangle
  def initialize(side_length)
    @height = side_length
    @width = side_length
  end
end
```



9. Consider the following program.

```ruby
class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch
```

Update this code so that when you run it, you see the following output:

```ruby
My cat Pudding is 7 years old and has black and white fur.
My cat Butterscotch is 10 years old and has tan and white fur.
```

A:

```ruby
class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, color)
    super(name, age)
    @color = color
  end
  
  def to_s
    "My cat #{@name} is #{@age} years old and has #{@color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch
```



10. Consider the following classes:

```ruby
class Car
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    4
  end

  def to_s
    "#{make} #{model}"
  end
end

class Motorcycle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    2
  end

  def to_s
    "#{make} #{model}"
  end
end

class Truck
  attr_reader :make, :model, :payload

  def initialize(make, model, payload)
    @make = make
    @model = model
    @payload = payload
  end

  def wheels
    6
  end

  def to_s
    "#{make} #{model}"
  end
end
```

Refactor these classes so they all use a common superclass, and inherit behavior as needed.

A:

```ruby
class Vehicle
  attr_reader :make, :model
  
  def initialize(make, model)
    @make = make
    @model = model
  end
  
  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end
```

