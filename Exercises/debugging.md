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



6. When attempting to sort an array of various lengths, we are surprised to see that an `ArgumentError` is raised.  Make the necessary changes to our code so that the various  lengths can be properly sorted and line 62 produces the expected output.

```ruby
class Length
  attr_reader :value, :unit

  def initialize(value, unit)
    @value = value
    @unit = unit
  end

  def as_kilometers
    convert_to(:km, { km: 1, mi: 0.6213711, nmi: 0.539957 })
  end

  def as_miles
    convert_to(:mi, { km: 1.609344, mi: 1, nmi: 0.8689762419 })
  end

  def as_nautical_miles
    convert_to(:nmi, { km: 1.8519993, mi: 1.15078, nmi: 1 })
  end

  def ==(other)
    case unit
    when :km  then value == other.as_kilometers.value
    when :mi  then value == other.as_miles.value
    when :nmi then value == other.as_nautical_miles.value
    end
  end

  def <(other)
    case unit
    when :km  then value < other.as_kilometers.value
    when :mi  then value < other.as_miles.value
    when :nmi then value < other.as_nautical_miles.value
    end
  end

  def <=(other)
    self < other || self == other
  end

  def >(other)
    !(self <= other)
  end

  def >=(other)
    self > other || self == other
  end

  def to_s
    "#{value} #{unit}"
  end

  private

  def convert_to(target_unit, conversion_factors)
    Length.new((value / conversion_factors[unit]).round(4), target_unit)
  end
end

# Example

puts [Length.new(1, :mi), Length.new(1, :nmi), Length.new(1, :km)].sort
# => comparison of Length with Length failed (ArgumentError)
# expected output:
# 1 km
# 1 mi
# 1 nmi
```

A:

On line 62, we invoke `Array#sort`.  It sorts the elements based on comparisons done by the `<=>` method. Therefore, the objects in the collection we are sorting must have access to a `<=>` method. Since our `Length` class does *not* implement a `<=>` method, we get an error saying that the "comparison of Length with Length failed".

In order to sort this array of `Length` objects, we need to implement a `Length#<=>` method, which we do.

If you want, you can remove the `==`, `<`, `<=`, `>`, and `>=` methods by adding `include Comparable`, as it implements all of the comparison methods based on `<=>`. However, you don't need to perform this step.



7. We created a simple `BankAccount` class with overdraft  protection, that does not allow a withdrawal greater than the amount of  the current balance. We wrote some example code to test our program.  However, we are surprised by what we see when we test its behavior. Why  are we seeing this unexpected output? Make changes to the code so that  we see the appropriate behavior.

```ruby
class BankAccount
  attr_reader :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    if amount > 0
      success = (self.balance -= amount)
    else
      success = false
    end

    if success
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  def balance=(new_balance)
    if valid_transaction?(new_balance)
      @balance = new_balance
      true
    else
      false
    end
  end

  def valid_transaction?(new_balance)
    new_balance >= 0
  end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
                          # Actual output: $80 withdrawn. Total balance is $50.
p account.balance         # => 50
```

A:

In Ruby, setter methods *always* return the argument that was passed in, even when you add an explicit `return` statement. Our `balance=` method will therefore always return its argument, irrespective of whether or not the instance variable `@balance` is re-assigned.

Because of this behavior, the invocation of `balance=` on line 21 of the original code will have a truthy return value even when our setter method does not re-assign `@balance`; it will never return `false`.

A better solution is to check the validity of the transaction by calling `valid_transaction?` in `withdraw` instead of `balance=`. If the transaction is deemed valid, we then invoke `balance=`, otherwise we don't. This way we don't attempt to use the setter for its return value, but instead let it do its one job: assigning a value to `@balance`.

```ruby
 def withdraw(amount)
    if amount > 0 && valid_transaction?(balance - amount)
      self.balance -= amount
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end
```



8. Valentina is using a new task manager program she wrote. When interacting with her task manager, an error is raised that surprises her. Can you find the bug and fix it?

```ruby
class TaskManager
  attr_reader :owner
  attr_accessor :tasks

  def initialize(owner)
    @owner = owner
    @tasks = []
  end

  def add_task(name, priority=:normal)
    task = Task.new(name, priority)
    tasks.push(task)
  end

  def complete_task(task_name)
    completed_task = nil

    tasks.each do |task|
      completed_task = task if task.name == task_name
    end

    if completed_task
      tasks.delete(completed_task)
      puts "Task '#{completed_task.name}' complete! Removed from list."
    else
      puts "Task not found."
    end
  end

  def display_all_tasks
    display(tasks)
  end

  def display_high_priority_tasks
    tasks = tasks.select do |task|
      task.priority == :high
    end

    display(tasks)
  end

  private

  def display(tasks)
    puts "--------"
    tasks.each do |task|
      puts task
    end
    puts "--------"
  end
end

class Task
  attr_accessor :name, :priority

  def initialize(name, priority=:normal)
    @name = name
    @priority = priority
  end

  def to_s
    "[" + sprintf("%-6s", priority) + "] #{name}"
  end
end

valentinas_tasks = TaskManager.new('Valentina')

valentinas_tasks.add_task('pay bills', :high)
valentinas_tasks.add_task('read OOP book')
valentinas_tasks.add_task('practice Ruby')
valentinas_tasks.add_task('run 5k', :low)

valentinas_tasks.complete_task('read OOP book')

valentinas_tasks.display_all_tasks
valentinas_tasks.display_high_priority_tasks
```

A:

We need to edit our `TaskManager#display_high_priority_tasks` instance method.

```ruby
def display_high_priority_tasks
    priority_tasks = tasks.select do |task|
      task.priority == :high
    end

    display(priority_tasks)
  end
```

When attempting to invoke the `tasks` getter method on line 35 in the code `tasks.select`, we are unintentionally referencing a local variable `tasks`. Since it has not yet been assigned a value, its value is `nil`, as reflected by the error message.

In more detail, what happens is the following. On line 35, Ruby first has to disambiguate the `tasks` name on the left-hand side of the assignment operator. It could in  principle be either local variable assignment, or an invocation of the  setter method. In this case, Ruby interprets it as local variable assignment. Recall that if we intended to invoke the `tasks=` setter method, we would need to use `self` to disambiguate from local variable assignment (`self.tasks=`). Next, Ruby must disambiguate the reference to `tasks` on the right-hand side of the assignment operator, seen in the code `tasks.select`. At this point, the getter method `tasks` is shadowed by the local variable that was just initialized on the left side of the assignment operator. You can see this shadowing at work  also in the private `display` method, where `tasks` in the method body refers to the method parameter, not the getter method.

As a result, both references to `tasks` on line 35 are  interpreted as a local variable. This means that we initialize a local  variable, and on the same line reference it via `tasks.select`, before it has been assigned a value.  Invoking the `select` method on `nil` caused the error we see.

In order to disambiguate this code so that Ruby will execute it as we intend, we best give our local variable a unique name, such as `high_priority_tasks`. This way it does not shadow the getter method. This is also in line with the Ruby style guide, which advises to "avoid shadowing methods with local variables unless they are both equivalent."



9. Can you decipher and fix the error that the following code produces?

```ruby
class Mail
  def to_s
    "#{self.class}"
  end
end

class Email < Mail
  attr_accessor :subject, :body

  def initialize(subject, body)
    @subject = subject
    @body = body
  end
end

class Postcard < Mail
  attr_reader :text

  def initialize(text)
    @text = text
  end
end

module Mailing
  def receive(mail, sender)
    mailbox << mail unless reject?(sender)
  end

  # Change if there are sources you want to block.
  def reject?(sender)
    false
  end

  def send(destination, mail)
    "Sending #{mail} from #{name} to: #{destination}"
    # Omitting the actual sending.
  end
end

class CommunicationsProvider
  attr_reader :name, :account_number

  def initialize(name, account_number=nil)
    @name = name
    @account_number = account_number
  end
end

class EmailService < CommunicationsProvider
  include Mailing

  attr_accessor :email_address, :mailbox

  def initialize(name, account_number, email_address)
    super(name, account_number)
    @email_address = email_address
    @mailbox = []
  end

  def empty_inbox
    self.mailbox = []
  end
end

class TelephoneService < CommunicationsProvider
  def initialize(name, account_number, phone_number)
    super(name, account_number)
    @phone_number = phone_number
  end
end

class PostalService < CommunicationsProvider
  attr_accessor :street_address, :mailbox

  def initialize(name, street_address)
    super(name)
    @street_address = street_address
    @mailbox = []
  end

  def change_address(new_address)
    self.street_address = new_address
  end
end

rafaels_email_account = EmailService.new('Rafael', 111, 'Rafael@example.com')
johns_phone_service   = TelephoneService.new('John', 122, '555-232-1121')
johns_postal_service  = PostalService.new('John', '47 Sunshine Ave.')
ellens_postal_service = PostalService.new('Ellen', '860 Blackbird Ln.')

puts johns_postal_service.send(ellens_postal_service.street_address, Postcard.new('Greetings from Silicon Valley!'))
# => undefined method `860 Blackbird Ln.' for #<PostalService:0x00005571b4aaebe8> (NoMethodError)
```

A:

This is a case of accidental method overriding.

On line 91, we intended to call `Mailing#send`, but since we forgot to `include Mailing` in `PostalService`, this does not happen. Why does Ruby not complain that there is no method `send`? First it looks for `send` on the method lookup path, and it actually finds a method with this name in the `Object` class. So it calls `Object#send`, which expects a method name as the first argument. Since the first argument we provide, `'860 Blackbird Ln.'`, is not the name of any method, we get an error.

In order to avoid overriding `Object#send`, we should rename our `Mailing#send` method to something unique, as seen in the solution above.

```ruby
module Mailing
  def receive(mail, sender)
    mailbox << mail unless reject?(sender)
  end

  # Change if there are sources you want to block.
  def reject?(sender)
    false
  end

  def send_mail(destination, mail)
    "Sending #{mail} from #{name} to: #{destination}"
    # Omitting the actual sending.
  end
end

class PostalService < CommunicationsProvider
  include Mailing

  # code omitted
end

puts johns_postal_service.send_mail(ellens_postal_service.street_address, Postcard.new('Greetings from Silicon Valley!'))
#=> Sending Postcard from John to: 860 Blackbird Ln.
```



10. We discovered [Gary Bernhardt's repository for finding out whether something rocks or not](https://github.com/garybernhardt/sucks-rocks), and decided to adapt it for a simple example.

```ruby
class AuthenticationError < Exception; end

# A mock search engine
# that returns a random number instead of an actual count.
class SearchEngine
  def self.count(query, api_key)
    unless valid?(api_key)
      raise AuthenticationError, 'API key is not valid.'
    end

    rand(200_000)
  end

  private

  def self.valid?(key)
    key == 'LS1A'
  end
end

module DoesItRock
  API_KEY = 'LS1A'

  class NoScore; end

  class Score
    def self.for_term(term)
      positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
      negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f

      positive / (positive + negative)
    rescue Exception
      NoScore
    end
  end

  def self.find_out(term)
    score = Score.for_term(term)

    case score
    when NoScore
      "No idea about #{term}..."
    when 0...0.5
      "#{term} is not fun."
    when 0.5
      "#{term} seems to be ok..."
    else
      "#{term} rocks!"
    end
  rescue Exception => e
    e.message
  end
end

# Example (your output may differ)

puts DoesItRock.find_out('Sushi')       # Sushi seems to be ok...
puts DoesItRock.find_out('Rain')        # Rain is not fun.
puts DoesItRock.find_out('Bug hunting') # Bug hunting rocks!
```

In order to test the case when authentication fails, we can simply set `API_KEY` to any string other than the correct key. Now, when using a wrong API key, we want our mock search engine to raise an `AuthenticationError`, and we want the `find_out` method to catch this error and print its error message `API key is not valid.`

Is this what you expect to happen given the code?

And why do we always get the following output instead?

```ruby
Sushi rocks!
Rain rocks!
Bug hunting rocks!
```

A:

