##### 1. Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

**A:** 

```ruby
class MyCar
attr_accessor :year, :color, :model, :current_speed
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end
  
  def speed_up
    puts "The motor revs higher!"
    self.current_speed += 1
  end
  
  def brake
    unless current_speed == 0
      puts "You hit the brakes."
    	self.current_speed -= 1
    end
  end
  
  def shut_off
    unless current_speed > 0
      puts "The motor shuts off."
    end
  end
end
```



##### 2. Add an accessor method to your MyCar class to change and view the color of your car. Then add an accessor method that allows you to view, but not modify, the year of your car.

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
  end
```



##### 3. You want to create a nice interface that allows you to accurately describe  the action you want your program to perform.  Create a method called `spray_paint` that can be called on an object and will modify the color of the car.

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

