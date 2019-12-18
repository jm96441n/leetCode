require 'test/unit'
require 'pry'
extend Test::Unit::Assertions

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
def add_two_numbers(l1, l2)
  carry = 0
  head = nil
  prev_node = nil
  while(l1 && l2)
    sum = l1.val + l2.val + carry
    if sum >= 10 
     carry, sum = sum.divmod(10)
    else
      carry = 0
    end
    node = ListNode.new(sum)
    head.nil? ? head = node : prev_node.next = node
    prev_node = node
    l1 = l1.next
    l2 = l2.next
  end

  clean_up_list = -> (list) {
    while list
      sum = list.val + carry
      if sum >= 10
        carry, sum = sum.divmod(10)
      else
        carry = 0
      end

      node = ListNode.new(sum)
      prev_node.next = node
      prev_node = node
      list = list.next
    end
  }

  if l1
    clean_up_list.(l1)
  elsif l2
    clean_up_list.(l2)
  end

  prev_node.next = ListNode.new(carry) if carry.positive?

  head
end

l1 = ListNode.new(1)
head2 = ListNode.new(9)
l2 = head2
head2.next = ListNode.new(9)

add_two_numbers(l1, l2)
