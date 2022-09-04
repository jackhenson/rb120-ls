1. On line 42 of our code, we intend to display information regarding the  books currently checked in to our community library.  Instead, an  exception is raised.  Determine what caused this error and fix the code  so that the data is displayed as expected.

```ruby
class Library
  attr_accessor :address, :phone, :books

  def initialize(address, phone)
    @address = address
    @phone = phone
    @books = []
  end

  def check_in(book)
    books.push(book)
  end
end

class Book
  attr_accessor :title, :author, :isbn

  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end

  def display_data
    puts "---------------"
    puts "Title: #{title}"
    puts "Author: #{author}"
    puts "ISBN: #{isbn}"
    puts "---------------"
  end
end

community_library = Library.new('123 Main St.', '555-232-5652')
learn_to_program = Book.new('Learn to Program', 'Chris Pine', '978-1934356364')
little_women = Book.new('Little Women', 'Louisa May Alcott', '978-1420951080')
wrinkle_in_time = Book.new('A Wrinkle in Time', 'Madeleine L\'Engle', '978-0312367541')

community_library.check_in(learn_to_program)
community_library.check_in(little_women)
community_library.check_in(wrinkle_in_time)

community_library.books.display_data
```

A:

The issue is that on line 42 we are calling the instance method `display_data` on an Array, not on an individual `Book` object. To fix this, we could change line 42 to

```ruby
community_library.books.each { |b| b.display_data }
```



2. The code below raises an exception.  Examine the error message and alter the code so that it runs without error.

```ruby
class Animal
  def initialize(diet, superpower)
    @diet = diet
    @superpower = superpower
  end

  def move
    puts "I'm moving!"
  end

  def superpower
    puts "I can #{@superpower}!"
  end
end

class Fish < Animal
  def move
    puts "I'm swimming!"
  end
end

class Bird < Animal
end

class FlightlessBird < Bird
  def initialize(diet, superpower)
    super
  end

  def move
    puts "I'm running!"
  end
end

class SongBird < Bird
  def initialize(diet, superpower, song)
    super
    @song = song
  end

  def move
    puts "I'm flying!"
  end
end

# Examples

unicornfish = Fish.new(:herbivore, 'breathe underwater')
penguin = FlightlessBird.new(:carnivore, 'drink sea water')
robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')
```

A:

An `ArgumentError` is raised due to line 37. By using the `super` keyword with no arguments, all of the arguments are passed to the superclass's `initialize` method.

To fix this, we can change the `SongBird` class to:

```ruby
class SongBird < Bird
  def initialize(diet, superpower, song)
    super(diet, superpower)
    @song = song
  end

  def move
    puts "I'm flying!"
  end
end
```



3. On lines 37 and 38 of our code, we can see that `grace` and `ada` are located at the same coordinates.  So why does line 39 output `false`? Fix the code to produce the expected output.

```ruby
class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true
                                    # actual: false
```

A:

When comparing the `GeoLocation` objects, we're using the `BasicObject` implementation `==` which compares to two objects. To compare these objects based on the value of their attributes, we must define a `==` method in the `GeoLocation` class which overrides `BasicObject#==`.

```ruby
class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end

  def ==(other_location)
    latitude == other_location.latitude && longitude == other_location.longitude
  end
end
```



4. We have written some code for a simple employee management system.  Each employee must have a unique serial number.  However, when we are  testing our program, an exception is raised.  Fix the code so that the  program works as expected without error.

```ruby
class EmployeeManagementSystem
  attr_reader :employer

  def initialize(employer)
    @employer = employer
    @employees = []
  end

  def add(employee)
    if exists?(employee)
      puts "Employee serial number is already in the system."
    else
      employees.push(employee)
      puts "Employee added."
    end
  end

  alias_method :<<, :add

  def remove(employee)
    if !exists?(employee)
      puts "Employee serial number is not in the system."
    else
      employees.delete(employee)
      puts "Employee deleted."
    end
  end

  def exists?(employee)
    employees.any? { |e| e == employee }
  end

  def display_all_employees
    puts "#{employer} Employees: "

    employees.each do |employee|
      puts ""
      puts employee.to_s
    end
  end

  private

  attr_accessor :employees
end

class Employee
  attr_reader :name

  def initialize(name, serial_number)
    @name = name
    @serial_number = serial_number
  end

  def ==(other)
    serial_number == other.serial_number
  end

  def to_s
    "Name: #{name}\n" +
    "Serial No: #{abbreviated_serial_number}"
  end

  private

  attr_reader :serial_number

  def abbreviated_serial_number
    serial_number[-4..-1]
  end
end

# Example

miller_contracting = EmployeeManagementSystem.new('Miller Contracting')

becca = Employee.new('Becca', '232-4437-1932')
raul = Employee.new('Raul', '399-1007-4242')
natasha = Employee.new('Natasha', '399-1007-4242')

miller_contracting << becca     # => Employee added.
miller_contracting << raul      # => Employee added.
miller_contracting << raul      # => Employee serial number is already in the system.
miller_contracting << natasha   # => Employee serial number is already in the system.
miller_contracting.remove(raul) # => Employee deleted.
miller_contracting.add(natasha) # => Employee added.

miller_contracting.display_all_employees
```

A:

We must make `Employee#serial_number` a protected method to all the other `Employee` object access when calling `Employee#==`.

```ruby
class Employee
  attr_reader :name

  def initialize(name, serial_number)
    @name = name
    @serial_number = serial_number
  end

  def ==(other)
    serial_number == other.serial_number
  end

  def to_s
    "Name: #{name}\n" +
    "Serial No: #{abbreviated_serial_number}"
  end

  protected

  attr_reader :serial_number

  private

  def abbreviated_serial_number
    serial_number[-4..-1]
  end
end
```



5. You started writing a very basic class for handling files. However, when you begin to write some simple test code, you get a `NameError`. The error message complains of an `uninitialized constant File::FORMAT`.

   What is the problem and what are possible ways to fix it?

```ruby
class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    "#{name}.#{FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true

puts blog_post
```

A:

The issue is that constants have lexical scope, meaning they are scoped to where they are defined in the source code. When trying to resolve a constant, Ruby looks it up in its lexical scope, in this case in the `File` class as well as in all of its ancestor classes. Since it doesn't find it in any of them, it throws a `NameError`.

```ruby
class File
  # code omitted

  def to_s
    "#{name}.#{format}"
  end
end

class MarkdownFile < File
  def format
    :md
  end
end

class VectorGraphicsFile < File
  def format
    :svg
  end
end

class MP3File < File
  def format
    :mp3
  end
end
```

