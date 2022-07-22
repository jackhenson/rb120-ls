1. Correct the following program so it will work properly. Assume that the  Customer and Employee classes have complete implementations; just make  the smallest possible change to ensure that objects of both types have  access to the `print_address` method.

```ruby
module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
  attr_reader :name, :address, :city, :state, :zipcode
end

betty = Customer.new 
bob = Employee.new
betty.print_address
bob.print_address
```

A:

```ruby
module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  include Mailable
  
  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
  include Mailable
  
  attr_reader :name, :address, :city, :state, :zipcode
end

betty = Customer.new 
bob = Employee.new
betty.print_address
bob.print_address
```



2. Correct the following program so it will work properly. Assume that the  Car class has a complete implementation; just make the smallest possible change to ensure that cars have access to the `drive` method.

```ruby
module Drivable
  def self.drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
```

A:

```ruby
module Drivable
  def drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
```



3. Assume you have the following code:

```ruby
class House
  attr_reader :price

  def initialize(price)
    @price = price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1
```

and this output:

```ruby
Home 1 is cheaper
Home 2 is more expensive
```

Modify the `House` class so that the above program will work. You are permitted to define only one new method in `House`.

A:

```ruby
class House
  attr_reader :price

  def initialize(price)
    @price = price
  end
  
  def <=>(other)
    price <=> other.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1
```



4. Write a class that will display:

```ruby
ABC
xyz
```

when the following code is run:

```ruby
my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')
```

A:

```ruby
class Transform
  attr_reader :data
  
	def initialize(data)
    @data = data
  end
  
  def uppercase
    data.upcase
  end
  
  def self.lowercase(data)
    data.downcase
  end
end
```



5. What will the following code print?

```ruby
class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata
puts thing.dupdata
```

A:

```ruby
ByeBye
HelloHello
```



6. Consider the following broken code:

```ruby
class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)
if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end
```

Modify this code so it works. Do not make the amount in the wallet accessible to any method that isn't part of the Wallet class.

A:

```ruby
class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end
  
  protected attr_reader :amount
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)
if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end
```



7. Consider the following code:

```ruby
butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
```

Write the classes and methods that will be necessary to make this code run, and print the following output:

```ruby
P Hanson has adopted the following pets:
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.
```

The order of the output does not matter, so long as all of the information is presented.

A:

```ruby
class Pet
  def initialize(type, name)
    @type = type
    @name = name
  end

  def to_s
    "a #{@type} named #{@name}"
  end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
  
  def number_of_pets
    @pets.size
  end

  def add_pet(pet)
    @pets << pet
  end

  def to_s
    @name
  end
end

class Shelter
  def initialize
    @adoptions = {}
  end
  
  def adopt(owner, pet)
    owner.add_pet(pet)
    @adoptions[owner] = owner.pets
  end
  
  def print_adoptions
    @adoptions.each do |k,v|
      puts "#{k} has adopted the following pets:"
      v.each { |pet| puts pet}
    end
  end
end
```



8. You have the following classes.

```ruby
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end
```

You need to modify the code so that this works:

```ruby
mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"
```

You are only allowed to write one new method to do this.

A:

```ruby
module Walkable
  def walk
    puts "#{name} #{gait} forward"
  end
end

class Person
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end
```



9. Now that we have a `Walkable` module, we are given a new  challenge. Apparently some of our users are nobility, and the regular  way of walking simply isn't good enough. Nobility need to strut.

   We need a new class `Noble` that shows the title and name when `walk` is called:

   ```ruby
   byron = Noble.new("Byron", "Lord")
   byron.walk
   # => "Lord Byron struts forward"
   ```

We must have access to both `name` and `title` because they are needed for other purposes that we aren't showing here.

```ruby
byron.name
=> "Byron"
byron.title
=> "Lord"
```

A:

```ruby
module Walkable
  def walk
    puts "#{self} #{gait} forward"
  end
end

class Person
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end

  private

  def gait
    "runs"
  end
end

class Noble
  include Walkable
  attr_reader :name, :title
  
  def initialize(name, title)
    @name = name
    @title = title
  end

  def to_s
    "#{title} #{name}"
  end
  
  private
  
  def gait
    "struts"
  end
end
```

