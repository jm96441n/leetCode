require 'test/unit'
require 'pry'
extend Test::Unit::Assertions

def is_palindrome(x)
  return false if x.negative?
  return true if x < 10
  return false if (x % 10).zero?

  palindrome = true

  i = 0
  i += 1 while 10**i < x

  i -= 1
  j = 1

  while j <= i
    front_dig = (x / 10**i) % 10

    last_dig = (x % 10**j) / (10**(j - 1))

    if front_dig != last_dig
      palindrome = false
      break
    end

    j += 1
    i -= 1
  end

  palindrome
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
