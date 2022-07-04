1. Modify the following code so that `Hello! I'm a cat!` is printed when `Cat.generic_greeting` is invoked.

```ruby
class Cat
end

Cat.generic_greeting
```

Expected output:

```ruby
Hello! I'm a cat!
```

A:

```ruby
class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting
```



2. Using the following code, add an instance method named `#rename` that renames `kitty` when invoked.

```ruby
class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

kitty = Cat.new('Sophie')
kitty.name
kitty.rename('Chloe')
kitty.name
```

Expected output:

```ruby
Sophie
Chloe
```

A:

```ruby
class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def rename(name)
    self.name = name
  end
end

kitty = Cat.new('Sophie')
kitty.name
kitty.rename('Chloe')
kitty.name
```



3. Using the following code, add a method named `#identify` that returns its calling object.

```ruby
class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

kitty = Cat.new('Sophie')
p kitty.identify
```

Expected output (yours may contain a different object id):

```ruby
#<Cat:0x007ffcea0661b8 @name="Sophie">
```

A:

```ruby
class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def identify
    self
  end
end

kitty = Cat.new('Sophie')
p kitty.identify
```



4. Using the following code, add two methods: `::generic_greeting` and `#personal_greeting`. The first method should be a class method and print a greeting that's  generic to the class. The second method should be an instance method and print a greeting that's custom to the object.

```ruby
class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting
```

Expected output:

```ruby
Hello! I'm a cat!
Hello! My name is Sophie!
```

A:

```ruby
class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end

  def personal_greeting
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting
```



5. Using the following code, create a class named `Cat` that tracks the number of times a new `Cat` object is instantiated. The total number of `Cat` instances should be printed when `::total` is invoked.

```ruby
kitty1 = Cat.new
kitty2 = Cat.new

Cat.total
```

Expected output:

```ruby
2
```

A:

```ruby
class Cat
  @@number_of_cats = 0

  def initialize
    @@number_of_cats += 1
  end

  def self.total
    puts @@number_of_cats
  end
end

kitty1 = Cat.new
kitty2 = Cat.new

Cat.total
```



6. Using the following code, create a class named `Cat` that prints a greeting when `#greet` is invoked. The greeting should include the name and color of the cat. Use a constant to define the color.

```ruby
kitty = Cat.new('Sophie')
kitty.greet
```

Expected output:

```ruby
Hello! My name is Sophie and I'm a purple cat!
```

A:

```ruby
class Cat
  COLOR = "orange"

  attr_accessor :name

  def initialize(name)
    self.name = name
  end

  def greet
    puts "Hello! My name is #{name} and I'm an #{COLOR} cat!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
```



7. Update the following code so that it prints `I'm Sophie!` when it invokes `puts kitty`.

```ruby
class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

kitty = Cat.new('Sophie')
puts kitty
```

Expected output:

```ruby
I'm Sophie!
```

A:

```ruby
class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "I'm #{name}!"
  end
end

kitty = Cat.new('Sophie')
puts kitty
```



8. Using the following code, create a class named `Person` with an instance variable named `@secret`. Use a setter method to add a value to `@secret`, then use a getter method to print `@secret`.

```ruby
person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
puts person1.secret
```

Expected output:

```ruby
Shh.. this is a secret!
```

A:

```ruby
class Person
  attr_accessor :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
puts person1.secret
```



9. Using the following code, add a method named `share_secret` that prints the value of `@secret` when invoked.

```ruby
class Person
  attr_writer :secret

  private

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
person1.share_secret
```

Expected output:

```ruby
Shh.. this is a secret!
```

A:

```ruby
class Person
  attr_writer :secret

  def share_secret
    puts secret
  end

  private

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
person1.share_secret
```



10. Using the following code, add an instance method named `compare_secret` that compares the value of `@secret` from `person1` with the value of `@secret` from `person2`.

```ruby
class Person
  attr_writer :secret

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)
```

Expected output:

```ruby
false
```

A:

```ruby
class Person
  attr_writer :secret

  def compare_secret(other_person)
    secret == other_person.secret
  end

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)
```

