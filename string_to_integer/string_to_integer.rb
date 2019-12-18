def my_atoi(str)
  alphabet = ('a'..'z').to_a + ('A'..'Z').to_a
  con_hsh = (0..9).each_with_object({}) { |d, obj| obj[d.to_s] = d }
  len = str.length - 1
  neg = false
  max = 2**31
  digits = []
  (0..len).each do |i|
    if str[i] == ' '
      next if digits.empty?

      break
    elsif str[i] == '-'
      neg = true
      next
    elsif alphabet.include?(str[i])
      break if digits.empty?

      next
    end

    digits << con_hsh[str[i]]
  end

  return 0 if digits.empty?

  len = digits.length - 1
  num = digits.each_with_index.reduce(0) { |acc, (d, i)| acc + (d * 10**(len - i)) }
  num *= -1 if neg
  
  num
end

p my_atoi("words and 987")
