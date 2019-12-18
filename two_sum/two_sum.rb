# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
  hsh = {}
  nums.each_with_index do |num, idx|
    diff = target - num
    return [idx, hsh[diff]] if hsh[diff]

    hsh[num] = idx
  end
end

p two_sum([2, 7, 11, 15], 9)
