# ----------------------------------------------------------------------------
# Write a function that will flatten an array of arbitrarily nested arrays
# of integers into a flat array of integers. e.g. [[1,2,[3]],4] → [1,2,3,4].
# If the language you're using has a function to flatten arrays,
# you should pretend it doesn't exist.
# ----------------------------------------------------------------------------


# Flatten nested array of integers
# Usage : array_flatten(nested_array)
#        eg:- array_flatten([1, [2, 3, [4, 5]]])
# This function will raise exception if input array contains element of other types.


def array_flatten(array_input, result = [])
  array_input.each do |element|
    if element.is_a? Array
      array_flatten(element, result)
    else
      raise "Unexpected element type!" if !element.is_a? Integer
      result << element
    end
  end
  result
end
