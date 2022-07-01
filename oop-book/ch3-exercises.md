##### 1. Add a class method to your MyCar class that calculates the gas mileage of any car.

**A:** 

```ruby
class MyCar
  attr_accessor :color
  attr_reader :year
    
    def initialize(year, color, model)
      @year = year
      @color = color
      @model = model
      @current_speed = 0
    end
  
		def self.gas_mileage(miles, gallons)
      "Gas mileage is #{miles/gallons} mpg."
    end
  
  	def to_s
      "This is a #{year} #{model} in the color #{color}."
    end
    
    def speed_up
      puts "The motor revs higher!"
      @current_speed += 1
    end
    
    def brake
      unless @current_speed == 0
        puts "You hit the brakes."
        @current_speed -= 1
      end
    end
    
    def shut_off
      unless @current_speed > 0
        puts "The motor shuts off."
      end
    end

    def spray_paint(color)
      puts "You spray the car with a new coat of paint."
      self.color = color
    end
  end
```



##### 2. Override the to_s method to create a user friendly print out of your object.

**A:** 

```ruby
class MyCar
  attr_accessor :year, :color, :model
    
    def initialize(year, color, model)
      @year = year
      @color = color
      @model = model
      @current_speed = 0
    end
  
		def self.gas_mileage(miles, gallons)
      "Gas mileage is #{miles/gallons} mpg."
    end
  
  	def to_s
      "This is a #{year} #{model} in the color #{color}."
    end
    
    def speed_up
      puts "The motor revs higher!"
      @current_speed += 1
    end
    
    def brake
      unless @current_speed == 0
        puts "You hit the brakes."
        @current_speed -= 1
      end
    end
    
    def shut_off
      unless @current_speed > 0
        puts "The motor shuts off."
      end
    end

    def spray_paint(color)
      puts "You spray the car with a new coat of paint."
      self.color = color
    end
  end

  car1 = MyCar.new(1995, 'yellow', 'Buick')

  puts car1
```



##### 3. When running the following code...

```ruby
class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
```

##### We get the following error

```ruby
test.rb:9:in `<main>': undefined method `name=' for
  #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)
```

##### Why do we get this error and how do we fix it?

**A:** 
We are using `attr_reader` instead of `attr_accessor` or `attr_writer`. Changing this will provide the setter method `name=`.

```ruby
class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
```

