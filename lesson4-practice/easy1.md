1. Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?
   1. `true`
   2. `"hello"`
   3. `[1, 2, 3, "happy days"]`
   4. `142`

A:

All of these options are Ruby objects. To find which class they belong to, simply invoke the `Kernel#class` method on each object.



2. If we have a `Car` class and a `Truck` class and we want to be able to `go_fast`, how can we add the ability for them to `go_fast` using the module `Speed`? How can you check if your `Car` or `Truck` can now go fast?

```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end
```

A:

You can give the `Car` and `Truck` classes access to `Speed#go_fast` by mixing in the `Speed` module to each class by invoking the `Module#include` method within each class definition. You can verify this by invoking the `go_fast` method on instance of either `Car` or `Truck`.



3. In the last question we had a module called `Speed` which contained a `go_fast` method. We included this module in the `Car` class as shown below.

```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end
```

When we called the `go_fast` method from an instance of the `Car` class (as shown below) you might have noticed that the `string` printed when we go fast includes the name of the type of vehicle we are using. How is this done?

```ruby
>> small_car = Car.new
>> small_car.go_fast
I am a Car and going super fast!
```

A:

This is accomplished through the use of the `self` keyword in the `go_fast` instance method definition. When used in an instance method, `self` refers to the calling object. Thus, when `class` is invoked on the `Car` instance, the name of the class, `Car` is output. This method call uses the syntax for string interpolation, which automatically calls `to_s`.



4. If we have a class `AngryCat` how do we create a new instance of this class?

   The `AngryCat` class might look something like this:

   ```ruby
   class AngryCat
     def hiss
       puts "Hisssss!!!"
     end
   end
   ```

A:

We create a new instance the class by invoking the `new` method on the class:

```ruby
cat1 = AngryCat.new
```



5. Which of these two classes has an instance variable and how do you know?

```ruby
class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end
```

A:

Only the `Pizza` class definition contains an `@instance_variable`.

You can check by invoking the `instance_variables` method on the instance of the class:

```ruby
hot_pizza = Pizza.new("cheese")
orange    = Fruit.new("apple")

>> hot_pizza.instance_variables
=> [:@name]
>> orange.instance_variables
=> []
```



6. What could we add to the class below to access the instance variable `@volume`?

```ruby
class Cube
  def initialize(volume)
    @volume = volume
  end
end
```

A:

Technically we don't need to add anything at all. We are able to access instance variables directly from the object by calling `instance_variable_get` on the instance. This would return something like this:

```ruby
>> big_cube = Cube.new(5000)
>> big_cube.instance_variable_get("@volume")
=> 5000
```

Otherwise, to access `@volume` we need to add a getter method by implemeting an accessor method with either the `attr_reader` method (which takes a symbol as an argument), or by defining a getter instance method `volume` that returns the instance variable.



7. What is the default return value of `to_s` when invoked on an object? Where could you go to find out if you want to be sure?

A:

The default return value of `to_s` is the name of the object's class and an encoding of the object id.



8. If we have a class such as the one below:

```ruby
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
```

You can see in the `make_one_year_older` method we have used `self`. What does `self` refer to here?

A:

Here, `self` refers to the calling object, an instance of the `Cat` class.



9. If we have a class such as the one below:

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

In the name of the `cats_count` method we have used `self`. What does `self` refer to in this context?

A:

Here, `self` is defined at the class level and refers to the class.



10. If we have the class below, what would you need to call to create a new instance of this class.

```ruby
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end
```

A:

You'd need to call `Bag.new` with two arguments for `color` and `material`.