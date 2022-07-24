1. If we have this code:

```ruby
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```

What happens in each of the following cases:

case 1:

```ruby
hello = Hello.new
hello.hi
```

A:
outputs `Hello`

case 2:

```ruby
hello = Hello.new
hello.bye
```

A:
`NoMethodError`

case 3:

```ruby
hello = Hello.new
hello.greet
```

A: 
`ArgumentError`

case 4:

```ruby
hello = Hello.new
hello.greet("Goodbye")
```

A:
Outputs `Goodbye`

case 5:

```ruby
Hello.hi
```

A:
`NoMethodError`



2. In the last question we had the following classes:

```ruby
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```

If we call `Hello.hi` we get an error message. How would you fix this?

A:
To solve this, you can define `hi` as a class method by using `self` in the method definition. However you cannot simply call `greet` in the `self.hi` method definition because the `Greeting` class only defines `greet` on its instances, rather than the `Greeting` class itself.

```ruby
class Hello
  def self.hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end
```



3. When objects are created they are a separate realization of a particular class.

   Given the class below, how do we create two different instances of this class with separate names and ages?

```ruby
class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end
```

A:

When we create the `AngryCat` objects, we pass the  constructor two values -- an age and a name. These values are assigned  to the new object's instance variables, and each object ends up with  different information.

To show this, lets create two cats.

```ruby
henry = AngryCat.new(12, "Henry")
alex   = AngryCat.new(8, "Alex")
```

We now have two different instances of the `AngryCat` class.

You will have noticed there is no `new` method inside of the `AngryCat` class, so how does Ruby know what to do when setting up the objects? By default, Ruby will call the `initialize` method on object creation.

Now we can confirm that each of our cats are different by asking for their ages and names.



4. Given the class below, if we created a new instance of the class and then called `to_s` on that instance we would get something like `"#<Cat:0x007ff39b356d30>"`

```ruby
class Cat
  def initialize(type)
    @type = type
  end
end
```

How could we go about changing the `to_s` output on this method to look like this: `I am a tabby cat`? (this is assuming that `"tabby"` is the `type` we passed in during initialization).

A:

We could define a `to_s` instance method within the `Cat` class definition:

```ruby
def to_s
  "I am a #{@type} cat"
end
```



5. If I have the following class:

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

What would happen if I called the methods like shown below?

```ruby
tv = Television.new
tv.manufacturer
tv.model

Television.manufacturer
Television.model
```

A:

`tv.manufacturer` and `Television.model` would raise a `NoMethodError`



6. If we have a class such as the one below:

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

In the `make_one_year_older` method we have used `self`. What is another way we could write this method so we don't have to use the `self` prefix?

A:

We could call the instance variable directly.



7. What is used in this class but doesn't add any value?

```ruby
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end
```

A:

The `return` in the `information` method. Ruby automatically returns the result of the last line of any method, so adding `return` to this line in the method does not add any value and so therefore should be avoided. 