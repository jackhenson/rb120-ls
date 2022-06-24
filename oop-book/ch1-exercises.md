##### 1. How do we create an object in Ruby? Give an example of the creation of an object.

**A:** Objects in Ruby (e.g., strings, numbers, arrays, classes, and modules- anything that can be said to have a value) are instantiated from classes. Classes are like molds and objects are like the things created from those molds. Objects are referred to as "instances" of a class. Two objects may different info, but can still be two instances of the same class. Ruby defines the attributes and behaviors of its objects in classes.

To create an object in Ruby, we can first define a class. Then we instantiate the object by using the `new` method to create an instance of the class (i.e. an object).

```ruby
class MyClass
end

my_obj = MyClass.new
```



##### 2. What is a module?  What is its purpose?  How do we use them with our  classes? Create a module for the class you created in exercise 1 and  include it properly.

**A:** A module is like a class, it holds a collection of behaviors (e.g. methods) that can be "mixed in" to different classes using the `include` class method. However, objects cannot be instantiated from modules. The purpose of a module is to extend the functionality of a class. Modules replace much of the need for multiple inheritance, which Ruby does not directly support. Modules are also useful for namespacing for more organized code.

```ruby
module MyModule
end

class MyClass
  include MyModule
end

my_obj = MyClass.new
```

