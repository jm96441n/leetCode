require 'pry'

class LRUCache
  attr_reader :capacity
  attr_accessor :map, :head, :tail, :cur_length

  class Node
    attr_accessor :nxt, :prev, :value, :key

    def initialize(value:, key:, nxt: nil, prev: nil)
      @nxt = nxt
      @prev = prev
      @value = value
      @key = key
    end
  end

=begin
  :type capacity: Integer
=end
  def initialize(capacity)
    @capacity = capacity
    @cur_length = 0
    @map = {}
    @head = nil
    @tail = nil
  end

=begin
  :type key: Integer
  :rtype: Integer
=end
  def get(key)
    node = map[key]

    return -1 if node.nil?

    return node.value if @head == node

    if cur_length == 2
      make_tail_head
    elsif @tail == node
      move_tail_back(node)
      set_head_to(node)
    else
      remove_node_between(node.prev, node.nxt)
      set_head_to(node)
    end

    node.value
  end


=begin
  :type key: Integer
  :type value: Integer
  :rtype: Void
=end
  # optimization idea: initialize all possible nodes on start and just reassign values rather than initialize a new
  # node every time
  def put(key, value)
    if map[key]
      put_existing_key(key, value)
    else
      put_new_key(key, value)
    end
    nil
  end

  private

  def put_existing_key(key, value)
    if map[key] == @tail && cur_length != 1
      make_tail_head
    elsif cur_length == 2
      make_tail_head
    elsif map[key] != @head
      remove_node_between(map[key].prev, map[key].nxt)
      set_head_to(map[key])
    end
    map[key].value = value
  end

  def put_new_key(key, value)
    node = Node.new(value: value, key: key)
    if @cur_length < @capacity
      add_node(node)
      @cur_length += 1
    else
      replace_tail(node)
    end

    set_head_to(node)
    map[key] = node
  end

  def add_node(node)
    if @head.nil?
      set_tail_to(node)
    elsif @head == @tail
      node.nxt = @tail
      @tail.prev = node
    end
  end

  def replace_tail(node)
    map.delete(@tail.key)
    if capacity == 1
      set_tail_to(node)
    else
      move_tail_back(@tail)
    end
  end

  def make_tail_head
    temp = @tail
    move_tail_back(@tail)
    set_head_to(temp)
  end

  def remove_node_between(prev_node, next_node)
    prev_node.nxt = next_node
    next_node.prev = prev_node
  end

  def set_head_to(node)
    if @head
      node.nxt = @head
      node.prev = nil
      @head.prev = node
    end

    @head = node
  end

  def set_tail_to(node)
    @tail = node
  end

  def move_tail_back(node)
    @tail = node.prev
    @tail.nxt = nil
  end
end
