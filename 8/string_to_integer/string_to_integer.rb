require 'test/unit'
extend Test::Unit::Assertions

# @param {String} str
# @return {Integer}
def my_atoi(str)
  con_hsh = {
    '0' => 0,
    '1' => 1,
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9
  }
  len = str.length - 1
  neg = false
  max = 2**31
  digits = []
  (0..len).each do |i|
    case str[i]
    when /\d/
      digits << con_hsh[str[i]]
    when /[-|+]/
      break if str[i + 1]&.match?(/\W/)
      break unless digits.empty?

      neg = true if str[i].match?(/[-]/)
    when /([.]|\w)/
      break
    when /(\s|\W)/
      break unless digits.empty?
    end
  end

  return 0 if digits.empty?

  len = digits.length - 1
  num = digits.each_with_index.reduce(0) { |acc, (d, i)| acc + (d * 10**(len - i)) }
  num *= -1 if neg
  if num > (max - 1)
    max - 1
  elsif num < -max
    -max
  else
    num
  end
end

test_cases = {
  '3.14234': 3,
  '5 + 5': 5,
  '.1': 0,
  '+-2': 0,
  '-+2': 0,
  'words and 987': 0,
  '   +0 123': 0,
  'abcdef+': 0,
  '-0012a42': -12,
  '0-1': 0
}

test_cases.each do |k, v|
  res = my_atoi(k.to_s)
  assert_equal(v, res, "#{k} was:\nResult: #{res}\nExpected: #{v}")
end
