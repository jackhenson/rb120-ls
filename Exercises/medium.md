1. Consider the following class:

```ruby
class Machine
  attr_writer :switch

  def start
    self.flip_switch(:on)
  end

  def stop
    self.flip_switch(:off)
  end

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end
```

Modify this class so both `flip_switch` and the setter method `switch=` are private methods.

A:

```ruby
class Machine
  def start
    self.flip_switch(:on)
  end

  def stop
    self.flip_switch(:off)
  end
    
  private

  attr_writer :switch
    
  def flip_switch(desired_state)
    self.switch = desired_state
  end
end
```



2. A fixed-length array is an array that always has a fixed number of  elements. Write a class that implements a fixed-length array, and  provides the necessary methods to support the following code:

```ruby
fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end
```

The above code should output `true` 16 times.

A:

```ruby
class FixedArray
  def initialize(arr_size)
    @arr = Array.new(arr_size)
  end

  def to_a
    @arr.clone
  end

  def to_s
    @arr.to_s
  end
   
  def [](idx)
    @arr.fetch(idx)
  end

  def []=(idx, value)
    self[idx]
    @arr[idx] = value
  end
end
```



3. Below we have 3 classes: `Student`, `Graduate`, and `Undergraduate`. The implementation details for the `#initialize` methods in `Graduate` and `Undergraduate` are missing. Fill in those missing details so that the following requirements are fulfilled:
   1. Graduate students have the option to use on-campus parking, while Undergraduate students do not.
   2. Graduate and Undergraduate students both have a name and year associated with them.

```ruby
class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
  end
end

class Undergraduate < Student
  def initialize(name, year)
  end
end
```

A:
```ruby
class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
# can delete this initialize method
  # def initialize(name, year)
  #   super
  # end
end
```



4. 