def some_method(input)
  input << 'danny'
  input = input
end

input = ['jim']
some_method input

a = 'hi there'
p a.object_id
p '--------'
b = a
p a.object_id
p b.object_id
p '--------'
a = ' danny'
p a.object_id
p b.object_id
p '--------'
a = a
p a.object_id
p b.object_id
p '--------'