# 1. a method that returns the sum of two integers
# 2. a method that takes an array of strings, and returns a string that is all those strings concatenated together
# 3. a method that takes an array of integers, and returns a new array with every other element

# 1. 
# METHOD SUM
#   Given integer1 and integer2
#   PRINT integer1 + integer2
# END

# 2. 
# METHOD CONCATENATE
#   Given array of strings
#   output string = empty string
#   FOR each element in array of strings
#     append element to output string
#   END FOR
#   PRINT output
# END

# 3.
# METHOD EVERY_OTHER
#   GIVEN input_array (array of integers)
#   SET output_array = empty array of integers
#   SET iterator = 1
#   SET skip = FALSE
#   WHILE iterator <= length of input_array
#     IF skip = TRUE then
#       append input_array[iterator] to output_array
#     END
#     SET skip = NOT skip
#   END WHILE
#   PRINT output_array
# END