require 'test/unit'
require 'pry'
extend Test::Unit::Assertions

def is_palindrome(x)
  n = x
  rev = 0

  while (x > 0)
    dig = x % 10
    rev = rev * 10 + dig
    x = x / 10
  end

  n == rev
end

test_cases = {
  121 => true,
  -121 => false,
  100 => false,
  10 => false,
  11 => true,
  123454321 => true,
  0 => true,
  1000030001 => false
}

test_cases.each do |k, v|
  assert_equal(v, is_palindrome(k), "Failed on #{k}")
end
