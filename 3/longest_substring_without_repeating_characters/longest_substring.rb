require 'test/unit'
require 'pry'
extend Test::Unit::Assertions

def length_of_longest_substring(s)
  len = s.length
  longest_substring = 0

  string_contains_repeated_characters = -> (string) {
        
  }

  longest_substring
end

test_cases = {
  'abcabcbb' => 3,
  'bbbb' => 1,
  'pwwkew' => 3,
  'aab' => 2,
  'dvdf' => 3
}

test_cases.each do |k, v|
  assert_equal(v, length_of_longest_substring(k))
end

