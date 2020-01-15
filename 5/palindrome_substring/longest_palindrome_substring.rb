require 'test/unit'
require 'pry'
extend Test::Unit::Assertions

def longest_palindrome(s)
  is_palindrome = ->(string) { string == string.reverse }

  return s if is_palindrome.call(s)

  maxes = []
  arr = s.split('').join('|').split('').push('|').unshift('|')
  longest = ''
  i = 0

  while i < arr.length
    j = 1
    j += 1 while i - j >= 0 && arr[i + j] == arr[i - j]
    j -= 1
    maxes << arr[(i - j)..(i + j)].length / 2

    i += 1
  end
  max = maxes.max
  longest = s[((maxes.index(max) - max) / 2)..(((maxes.index(max) + max) / 2) - 1)]
  longest
end

test_cases = {
  'abad' => 'aba',
  'cbbd' => 'bb',
  'a' => 'a',
  'ac' => 'a'
}

test_cases.each do |k, v|
  assert_equal(v, longest_palindrome(k), "Failed on #{k}")
end
