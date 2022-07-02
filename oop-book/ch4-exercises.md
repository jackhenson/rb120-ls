##### 1. Create a superclass called `Vehicle` for your `MyCar` class to inherit from and move the behavior that isn't specific to the `MyCar` class to the superclass. Create a constant in your `MyCar` class that stores information about the vehicle that makes it different from other types of Vehicles.

##### Then create a new class called MyTruck that inherits from your  superclass that also has a constant defined that separates it from the  MyCar class in some way.

**A:** 

```ruby
class Vehicle
  attr_accessor :year, :color, :model, :speed

  def initialize(year, color, model)
    self.year = year
    self.color = color
    self.model = model
    self.speed = 0
  end

  def to_s
    "This is a #{year} #{model} in the color #{color}."
  end

  def self.gas_mileage(miles, gallons)
    "Gas mileage is #{miles/gallons} mpg."
  end

  def speed_up
    puts "The motor revs higher!"
    @speed += 1
  end
  
  def brake
    unless @speed == 0
      puts "You hit the brakes."
      @speed -= 1
    end
  end
  
  def shut_off
    unless @speed > 0
      puts "The motor shuts off."
    end
  end

  def spray_paint(color)
    puts "You spray the car with a new coat of paint."
    self.color = color
  end
end

class MyCar < Vehicle
  TRANSMISSION = 'manual'
end

class MyTruck < Vehicle
  TRANSMISSION = 'automatic'
end
```



##### 2. Add a class variable to your superclass that can keep track of the  number of objects created that inherit from the superclass. Create a  method to print out the value of this class variable as well.

**A:** 

```ruby
class Vehicle
  attr_accessor :year, :color, :model, :speed

  @@number_of_vehicles = 0
  
  def initialize(year, color, model)
    self.year = year
    self.color = color
    self.model = model
    self.speed = 0
    @@number_of_vehicles += 1
  end

  def self.total_number_of_vehicles
    @@number_of_vehicles
  end

  def to_s
    "This is a #{year} #{model} in the color #{color}."
  end

  def self.gas_mileage(miles, gallons)
    "Gas mileage is #{miles/gallons} mpg."
  end

  def speed_up
    puts "The motor revs higher!"
    @speed += 1
  end
  
  def brake
    unless @speed == 0
      puts "You hit the brakes."
      @speed -= 1
    end
  end
  
  def shut_off
    unless @speed > 0
      puts "The motor shuts off."
    end
  end

  def spray_paint(color)
    puts "You spray the car with a new coat of paint."
    self.color = color
  end
end

class MyCar < Vehicle
  TRANSMISSION = 'manual'
end

class MyTruck < Vehicle
  TRANSMISSION = 'automatic'
end
```



##### 3. Create a module that you can mix in to ONE of your subclasses that describes a behavior unique to that subclass.

**A:** 

```ruby
class Vehicle
  attr_accessor :year, :color, :model, :speed

  @@number_of_vehicles = 0

  def initialize(year, color, model)
    self.year = year
    self.color = color
    self.model = model
    self.speed = 0
    @@number_of_vehicles += 1
  end

  def self.total_number_of_vehicles
    @@number_of_vehicles
  end

  def to_s
    "This is a #{year} #{model} in the color #{color}."
  end

  def self.gas_mileage(miles, gallons)
    "Gas mileage is #{miles/gallons} mpg."
  end

  def speed_up
    puts "The motor revs higher!"
    @speed += 1
  end
  
  def brake
    unless @speed == 0
      puts "You hit the brakes."
      @speed -= 1
    end
  end
  
  def shut_off
    unless @speed > 0
      puts "The motor shuts off."
    end
  end

  def spray_paint(color)
    puts "You spray the car with a new coat of paint."
    self.color = color
  end
end

module Towable
  def can_tow?
    true
  end
end

class MyCar < Vehicle
  TRANSMISSION = 'manual'
end

class MyTruck < Vehicle
  TRANSMISSION = 'automatic'

  include Towable
end
```



##### 4. Print to the screen your method lookup for the classes that you have created.

**A:** 

```ruby
puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors
```



##### 5. Move all of the methods from the MyCar class that also pertain to the  MyTruck class into the Vehicle class. Make sure that all of your  previous method calls are working when you are finished.

**A:** 

Already done in answer 1.



##### 6. Write a method called `age` that calls a private method to  calculate the age of the vehicle. Make sure the private method is not  available from outside of the class.  You'll need to use Ruby's built-in [Time](http://ruby-doc.org/core-2.1.0/Time.html) class to help.

**A:** 

```ruby
class Vehicle
  attr_accessor :year, :color, :model, :speed

  @@number_of_vehicles = 0

  def initialize(year, color, model)
    self.year = year
    self.color = color
    self.model = model
    self.speed = 0
    @@number_of_vehicles += 1
  end

  def self.total_number_of_vehicles
    @@number_of_vehicles
  end

  def age
    "#{current_year - self.year} years old"
  end

  def to_s
    "This is a #{year} #{model} in the color #{color}."
  end

  def self.gas_mileage(miles, gallons)
    "Gas mileage is #{miles/gallons} mpg."
  end

  def speed_up
    puts "The motor revs higher!"
    @speed += 1
  end
  
  def brake
    unless @speed == 0
      puts "You hit the brakes."
      @speed -= 1
    end
  end
  
  def shut_off
    unless @speed > 0
      puts "The motor shuts off."
    end
  end

  def spray_paint(color)
    puts "You spray the car with a new coat of paint."
    self.color = color
  end

  private

  def current_year
    Time.new.year
  end
end

module Towable
  def can_tow?
    true
  end
end

class MyCar < Vehicle
  TRANSMISSION = 'manual'
end

class MyTruck < Vehicle
  TRANSMISSION = 'automatic'

  include Towable
end
```



##### 7. Create a class 'Student' with attributes `name` and  `grade`. Do NOT make the grade getter public, so `joe.grade` will raise an error. Create a `better_grade_than?` method, that you can call like so...

```ruby
puts "Well done!" if joe.better_grade_than?(bob)
```

**A:**

```ruby
class Student
  attr_accessor :name

  def initialize(name, grade)
    self.name = name
    @grade = grade
  end

  def better_grade_than?(peer)
    grade > peer.grade
  end

  protected

  attr_reader :grade
end
```



##### 8. Given the following code...

```ruby
bob = Person.new
bob.hi
```

And the corresponding error message...

```ruby
NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
from (irb):8
from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'
```

What is the problem and how would you go about fixing it?

**A:**

The problem is that the method `hi` is a private method, therefore it is unavailable to the object. Private methods can only be called inside the class in which they're defined.
