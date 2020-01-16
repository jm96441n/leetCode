require 'test/unit'
require 'pry'
extend Test::Unit::Assertions

def convert(s, num_rows)
  return s if num_rows == 1

  rows = {}
  (0...num_rows).map { |i| rows[i] = '' }

  i = 0
  j = 0
  cols_between_rows = num_rows - 2
  totals = num_rows + cols_between_rows
  while j < s.length
    if i < num_rows
      rows[i] += s[j]
    else
      rows[totals - i] += s[j]
    end
    i == (totals - 1) ? i = 0 : i += 1
    j += 1
  end

  rows.reduce('') { |acc, (_, value)| acc + value }
end

test_cases = {
  'PAHNAPLSIIGYIR' => ['PAYPALISHIRING', 3],
  'PINALSIGYAHRPI' => ['PAYPALISHIRING', 4],
  'ABC' => ['ABC', 1]
}

test_cases.each do |k, v|
  assert_equal(k, convert(v[0], v[1]), "Failed on #{v[0]}, #{v[1]}")
end
