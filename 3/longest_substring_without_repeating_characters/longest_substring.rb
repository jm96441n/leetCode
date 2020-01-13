require 'test/unit'
require 'pry'
extend Test::Unit::Assertions

=begin
def length_of_longest_substring(s)
  len = s.length
  longest_substring = 0
  i = 0

  return 1 if len == 1

  while i < len - 1
    j = i + 1
    cur_length = 1
    while j < len
      if s[i...j].include?(s[j])
        longest_substring = cur_length > longest_substring ? cur_length : longest_substring
        break
      elsif s[j] == s[-1]
        cur_length += 1
        longest_substring = cur_length > longest_substring ? cur_length : longest_substring
        break;
      end
      cur_length += 1
      j += 1
    end
    i += 1
  end

  longest_substring
end
=end

# faster, but no fun functional code
def longest_substring(s)
  cur_length = 1
  longest_substring = 1
  len = s.length
  i = 1

  return 0 if len == 0

  visited = {}
  visited[s[0]] = 0

  while i < len
    prev_index = visited[s[i]]
    if prev_index.nil? || (i - cur_length > prev_index)
      cur_length += 1
    else
      longest_substring = cur_length if cur_length > longest_substring
      cur_length = i - prev_index
    end

    visited[s[i]] = i
    i += 1
  end

  longest_substring = cur_length if cur_length > longest_substring
  longest_substring
end

# with currying!
def length_of_longest_substring(s)
  cur_length = 1
  longest_substring = 1
  len = s.length
  i = 1

  return 0 if len == 0

  visited = {}
  visited[s[0]] = 0

  max_fn = ->(a) { ->(b) { [a, b].max } }

  max_first = max_fn.(longest_substring)
  while i < len
    prev_index = visited[s[i]]
    if prev_index.nil? || (i - cur_length > prev_index)
      cur_length += 1
    else
      longest_substring = max_first.(cur_length)
      max_first = max_fn.(longest_substring)
      cur_length = i - prev_index
    end

    visited[s[i]] = i
    i += 1
  end

  longest_substring = max_first.(cur_length)
  longest_substring
end

test_cases = {
  'abcabcbb' => 3,
  'bbbb' => 1,
  'pwwkew' => 3,
  'aab' => 2,
  'dvdf' => 3,
  'a' => 1,
  ' ' => 1,
  'cdd' => 2,
  '' => 0
}

#assert_equal(2, length_of_longest_substring('aab'), "Failed on aab")
test_cases.each do |k, v|
  assert_equal(v, length_of_longest_substring(k), "Failed on #{k}")
end

