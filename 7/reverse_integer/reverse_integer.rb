# @param {Integer} x
# @return {Integer}
def reverse(x)
  neg = false

  if x.negative?
    x *= -1
    neg = true
  end


  reverse_dig = lambda { |number, power, acc = 0|
    quot, remainder = number.divmod(10)
    acc += remainder * 10**power
    quot.zero? ? acc : reverse_dig.(quot, power - 1, acc)
  }

  power = x.zero? ? 0 : Math.log(x, 10).floor
  num = reverse_dig.(x, power)
  num *= -1 if neg
  max = 2**31
  (num > max - 1) || (num < -max) ? 0 : num
end

p reverse(123)
