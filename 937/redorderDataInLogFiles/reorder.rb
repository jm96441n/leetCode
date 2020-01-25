require 'test/unit'
require 'pry'
extend Test::Unit::Assertions

# @param {String[]} logs
# @return {String[]}
def reorder_log_files(logs)
  dig_arr = []
  let_arr = Array.new(logs.length)

  logs.each do |log|
    idx = log_start_idx(log)
    if log[idx].match?(/\d/)
      dig_arr << log
    else
      i = 0
      check_str = log[idx..-1]

      log_to_add = log

      while i < let_arr.length
        if let_arr[i].nil?
          let_arr[i] = log_to_add
          break
        end

        let_arr_check_str = let_arr[i][log_start_idx(let_arr[i])..-1]
        # string is less t
        if (check_str < let_arr_check_str) || (check_str == let_arr_check_str && log_to_add[0...idx] < let_arr[i][0...log_start_idx(let_arr[i])])
          let_arr[i], log_to_add = swap(let_arr[i], log_to_add)
        end
        i += 1
      end
    end
  end

  let_arr.compact + dig_arr
end

def log_start_idx(log)
  (/\s/ =~ log) + 1
end

def swap(a, b)
  [b, a]
end

test_cases = {}
[
 [
   ["dig1 8 1 5 1","let1 art can","dig2 3 6","let2 own kit dig","let3 art zero"],
   ["let1 art can","let3 art zero","let2 own kit dig","dig1 8 1 5 1","dig2 3 6"]
 ],
 [
    ["a1 9 2 3 1","g1 act car","zo4 4 7","ab1 off key dog","a8 act zoo"],
    ["g1 act car","a8 act zoo","ab1 off key dog","a1 9 2 3 1","zo4 4 7"]
 ],
 [
    ["a1 9 2 3 1","g1 act car","zo4 4 7","ab1 off key dog","a8 act zoo","a2 act car"],
    ["a2 act car","g1 act car","a8 act zoo","ab1 off key dog","a1 9 2 3 1","zo4 4 7"]
 ]
].map { |arr| test_cases[arr[0].to_json] = arr[1] }

test_cases.each do |input, output|
  assert_equal(output, reorder_log_files(JSON.parse(input)))
end
