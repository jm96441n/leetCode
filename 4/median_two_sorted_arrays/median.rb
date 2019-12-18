require 'test/unit'
require 'pry'
extend Test::Unit::Assertions

def find_median_sorted_arrays(nums1, nums2)
  new_arr = []
  i = 0
  j = 0

  while i < nums1.length && j < nums2.length
    if nums1[i] < nums2[j]
      new_arr << nums1[i]
      i += 1
    else
      new_arr << nums2[j]
      j += 1
    end
  end

  if j < nums2.length
    new_arr.concat(nums2[j..-1])
  end

  if i < nums1.length
    new_arr.concat(nums1[i..-1])
  end

  if new_arr.length.odd?
    mdpt = (new_arr.length / 2.0).ceil
    new_arr[mdpt - 1]
  else
    mdpt = (new_arr.length / 2.0) - 1
    (new_arr[mdpt] + new_arr[mdpt + 1]) / 2.0
  end
end

test_cases = {
  2.0 => [[1, 3], [2]],
  2.5 => [[1, 2], [3, 4]]
}

test_cases.each do |k, v|
  assert_equal(k, find_median_sorted_arrays(v[0], v[1]), "Failed on #{v}")
end

