require 'test/unit'
require 'pry'
extend Test::Unit::Assertions

def longest_palindrome(s)
  is_palindrome = ->(string) { string == string.reverse }

end

test_cases = {
  'babad' => 'aba',
  'cbbd' => 'bb'
}

test_cases.each do |k, v|
  assert_equal(v, longest_palindrome(k), "Failed on #{k}")
end
