require 'test/unit'
require 'pry'
extend Test::Unit::Assertions

def length_of_longest_substring(s)
  len = s.length
  longest_substring = 0
  i = 0

  return 1 if len == 1

  while i < len
    j = i + 1
    while j < len
      if s[i...j].include?(s[j])
        longest_substring = s[i...j].length > longest_substring ? s[i...j].length : longest_substring
        break
      elsif j == len - 1
        longest_substring = s[i..j].length > longest_substring ? s[i..j].length : longest_substring
        break
      end
      j += 1
    end
    i += 1
  end

  longest_substring
end

test_cases = {
  'abcabcbb' => 3,
  'bbbb' => 1,
  'pwwkew' => 3,
  'aab' => 2,
  'dvdf' => 3,
  'a' => 1,
  ' ' => 1
}

test_cases.each do |k, v|
  assert_equal(v, length_of_longest_substring(k), "Failed on #{k}")
end

