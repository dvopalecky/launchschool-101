# Danny's notes for 101 Course

## Local variable scope
- method scope
  - only access to variables that are passed to the method
- block scope
  - block defined by `{ }` or `do/end` AND follows a method invocation
    - e.g. `for i in arr { }` is NOT a block
  - in inner scope both inner and outer scope local variables are accesible
  - local variable initialized in inner scope is NOT accesible in outer scope

## How passing an object into a method can or cannot permanently change the object
- you need to search the docs to see if the object is mutated within the method
  or not
- usually, if "!" is at the end of the method, most likely it mutates the caller
- when naming a method, use verbs so that it could be easier to see if method
  mutates the caller or not, e.g. `display` probably won't mutate, but `update`
  probably will
- objects are passed by reference to a value
- we need to know if a method outputs a NEW object or just mutates
  EXISTING object

## Passing by value vs. by reference
- methods that modify / mutates the input (destructive)
  - "<<" method
- methods that do NOT modify input (non-destructive)
  - re-assignment (to point to a different object)
  - string concatenation
- for now think of variables as pointers to objects

## Ruby's syntactical sugar:
- method invocation can be with or without parentheses
- if we have a method without parentheses and a local variable with the same
  name, local variable has precedence
- `bob.name = 'Bob'` is in fact `bob.name=('Bob')`

## Types of Variables
- `local`
- `$global`
- `@@class`
- `@instance`
- `CONSTANT`

## Where do Ruby methods come from
- core library
- standard library (need to load with required)
- gems
- `require_relative('abc')` loads local file `abc.rb`

## Collections
- collections are mostly arrays, hashes (dictionaries) and strings
- symbols are in a way similar to strings, but immutable
- hash retrieval:
  - `hash[key]` returns nil if key not found
  - `hast.fetch(key)` raises error if key not found
- use precise words: return value, mutated, outputed
- Array
  - `each`: returns original array
  - `select`: returns new array, which is a sub-array of the original array based
            truthiness of return value of the block for each element.
  - `map`: returns new array, based on the block's return value. each element is
         transformed based on return value
- Hash
  - `each`: has 2 arguments
- Enumerable methods work for both arrays and hashes
- Be careful about having arrays in hashes and vice versa, because when you
  mutate the inside element, the whole array / hash is changed as well.

## Debugging tips
### Personal
- patient temperament
- code with intention
- fanatical attention to details

### General Approach
- reproduce the error consistently
- not just squash the symptom, but understand the problem well
- figure out a solution
- pay attention to "code smells"

### Methods
- exctract code to methods
- naming: verbs, consistent naming, same level of abstraction
- if method displays something, prepend with display, print etc.

## Other concepts
- metaprograming: modify code at runtime
