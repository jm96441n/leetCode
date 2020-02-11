require 'test/unit'
require 'pry'
extend Test::Unit::Assertions

# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next
  def initialize(val)
    @val = val
    @next = nil
  end
end

# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
=begin
def merge_two_lists(l1, l2)
  head = nil
  node = nil

  while(l1 && l2)
    if l1.val < l2.val
      node, l1 = move_existing_node(l1, node)
    else
      node, l2 = move_existing_node(l2, node)
    end
    head = node if head.nil?
  end

  while l1
    node, l1 = move_existing_node(l1, node)
    head = node if head.nil?
  end

  while l2
    node, l2 = move_existing_node(l2, node)
    head = node if head.nil?
  end
  head
end

def move_node(node)
  [node, node.next]
end

def move_existing_node(node, new_node)
  return move_node(node) if new_node.nil?

  new_node.next = node
  move_node(node)
end
=end

# recursive solution from the answers
def merge_two_lists(l1, l2)
  return l2 if l1.nil?
  return l1 if l2.nil?

  if l1.val < l2.val
    l1.next = merge_two_lists(l1.next, l2)
    return l1
  else
    l2.next = merge_two_lists(l1, l2.next)
    return l2
  end
end

l1 = ListNode.new(1)
l2 = ListNode.new(1)
ans = ListNode.new(1)

node = l1
[2, 4].each do |val|
  n = ListNode.new(val)
  node.next = n
  node = n
end

node = l2
[3, 4].each do |val|
  n = ListNode.new(val)
  node.next = n
  node = n
end

def extract_values(list)
  arr = []
  while list
    arr << list.val
    list = list.next
  end
  arr
end

expected = [1, 1, 2, 3, 4, 4]
listed = merge_two_lists(l1, l2)
ans = extract_values(listed)

assert_equal(expected, ans)
