require 'test/unit'
require_relative 'lru_cache'

class LRUCacheTest
  include Test::Unit::Assertions

  def initialize; end

  def test_get_returns_negative_when_val_not_found
    lru = LRUCache.new(5)
    assert_equal(-1, lru.get(3))
  end

  def test_get_returns_value
    lru = LRUCache.new(5)
    lru.put(1, 4)
    lru.put(2, 5)
    assert_equal(5, lru.get(2), 'Getting first value')
    assert_equal(4, lru.get(1), 'Getting first value')
  end

  def test_get_sets_head_to_most_recent_value
    lru = LRUCache.new(5)
    lru.put(1, 4)
    lru.put(2, 5)
    lru.put(3, 6)
    lru.put(4, 7)
    lru.put(5, 8)
    assert_equal(8, lru.head.value, 'Getting value for head failed')
    lru.get(3)
    assert_equal(6, lru.head.value, 'Getting value for head failed')
  end

  def test_put_adds_first_key
    lru = LRUCache.new(5)
    lru.put(1, 4)
    assert_equal(lru.get(1), 4)
    assert_equal(4, lru.head.value)
    assert_equal(4, lru.tail.value)
  end

  def test_put_adds_second_key
    lru = LRUCache.new(5)
    lru.put(1, 4)
    lru.put(2, 5)
    assert_equal(4, lru.get(1), 'Getting first key failed')
    assert_equal(5, lru.get(2), 'Getting second key failed')
    assert_equal(5, lru.head.value, 'Getting value for head failed')
    assert_equal(4, lru.tail.value, 'Getting value for tail failed')
  end

  def test_put_adds_keys_to_capacity
    lru = LRUCache.new(5)
    lru.put(1, 4)
    lru.put(2, 5)
    lru.put(3, 6)
    lru.put(4, 7)
    lru.put(5, 8)
    assert_equal(4, lru.get(1), 'Getting first key failed')
    assert_equal(5, lru.get(2), 'Getting second key failed')
    assert_equal(6, lru.get(3), 'Getting first key failed')
    assert_equal(7, lru.get(4), 'Getting first key failed')
    assert_equal(8, lru.get(5), 'Getting first key failed')
    assert_equal(8, lru.head.value, 'Getting value for head failed')
    assert_equal(4, lru.tail.value, 'Getting value for tail failed')
  end

  def test_put_remove_lru_after_capacity
    lru = LRUCache.new(5)
    lru.put(1, 4)
    lru.put(2, 5)
    lru.put(3, 6)
    lru.put(4, 7)
    lru.put(5, 8)
    lru.put(6, 9)
    assert_equal(5, lru.get(2), 'Getting second key failed')
    assert_equal(6, lru.get(3), 'Getting first key failed')
    assert_equal(7, lru.get(4), 'Getting first key failed')
    assert_equal(8, lru.get(5), 'Getting first key failed')
    assert_equal(9, lru.get(6), 'Getting first key failed')
    assert_equal(-1, lru.get(1), 'Getting first key failed')
  end

  def test_put_remove_with_repeated_keys
    lru = LRUCache.new(2)
    assert_equal(-1, lru.get(2))
    lru.put(2, 6)
    assert_equal(-1, lru.get(1))
    lru.put(1, 5)
    lru.put(1, 2)
    assert_equal(2, lru.get(1))
    assert_equal(6, lru.get(2))
  end

  def test_put_remove_with_multiple_repeated_keys
    lru = LRUCache.new(2)
    lru.put(2, 1)
    lru.put(2, 2)
    assert_equal(2, lru.get(2))
    lru.put(1, 1)
    lru.put(4, 1)
    assert_equal(-1, lru.get(2))
  end

  def test_put_remove_with_capacity_of_one
    lru = LRUCache.new(1)
    lru.put(1, 4)
    lru.put(2, 5)
    lru.put(3, 6)
    lru.put(4, 7)
    lru.put(5, 8)
    lru.put(6, 9)
    assert_equal(-1, lru.get(2), 'Getting second key failed')
    assert_equal(-1, lru.get(3), 'Getting first key failed')
    assert_equal(-1, lru.get(4), 'Getting first key failed')
    assert_equal(-1, lru.get(5), 'Getting first key failed')
    assert_equal(-1, lru.get(1), 'Getting first key failed')
    assert_equal(9, lru.get(6), 'Getting first key failed')
  end

  def long_test
    lru = LRUCache.new(10)
    cmd = ["put","put","put","put","put","get","put","get","get","put","get","put","put","put","get","put","get","get","get","get","put","put","get","get","get","put","put","get","put","get","put","get","get","get","put","put","put","get","put","get","get","put","put","get","put","put","put","put","get","put","put","get","put","put","get","put","put","put","put","put","get","put","put","get","put","get","get","get","put","get","get","put","put","put","put","get","put","put","put","put","get","get","get","put","put","put","get","put","put","put","get","put","put","put","get","get","get","put","put","put","put","get","put","put","put","put","put","put","put"]
    args = [[10,13],[3,17],[6,11],[10,5],[9,10],[13],[2,19],[2],[3],[5,25],[8],[9,22],[5,5],[1,30],[11],[9,12],[7],[5],[8],[9],[4,30],[9,3],[9],[10],[10],[6,14],[3,1],[3],[10,11],[8],[2,14],[1],[5],[4],[11,4],[12,24],[5,18],[13],[7,23],[8],[12],[3,27],[2,12],[5],[2,9],[13,4],[8,18],[1,7],[6],[9,29],[8,21],[5],[6,30],[1,12],[10],[4,15],[7,22],[11,26],[8,17],[9,29],[5],[3,4],[11,30],[12],[4,29],[3],[9],[6],[3,4],[1],[10],[3,29],[10,28],[1,20],[11,13],[3],[3,12],[3,8],[10,9],[3,26],[8],[7],[5],[13,17],[2,27],[11,15],[12],[9,19],[2,15],[3,16],[1],[12,17],[9,1],[6,19],[4],[5],[5],[8,1],[11,7],[5,2],[9,28],[1],[2,2],[7,4],[4,22],[7,24],[9,26],[13,28],[11,26]]
    output =[nil,nil,nil,nil,nil,-1,nil,19,17,nil,-1,nil,nil,nil,-1,nil,-1,5,-1,12,nil,nil,3,5,5,nil,nil,1,nil,-1,nil,30,5,30,nil,nil,nil,-1,nil,-1,24,nil,nil,18,nil,nil,nil,nil,-1,nil,nil,18,nil,nil,-1,nil,nil,nil,nil,nil,18,nil,nil,-1,nil,4,29,30,nil,12,-1,nil,nil,nil,nil,29,nil,nil,nil,nil,17,22,18,nil,nil,nil,-1,nil,nil,nil,20,nil,nil,nil,-1,18,18,nil,nil,nil,nil,20,nil,nil,nil,nil,nil,nil,nil] 
    i = 0
    while i < cmd.length
      assert_equal(output[i], lru.send(cmd[i].to_sym, *args[i]), "Failed on #{cmd[i]} with args #{args[i]} at #{i}")
      i += 1
    end
  end
end

LRUCacheTest.new.test_get_returns_negative_when_val_not_found
LRUCacheTest.new.test_get_returns_value
LRUCacheTest.new.test_get_sets_head_to_most_recent_value
LRUCacheTest.new.test_put_adds_first_key
LRUCacheTest.new.test_put_adds_second_key
LRUCacheTest.new.test_put_adds_keys_to_capacity
LRUCacheTest.new.test_put_remove_lru_after_capacity
LRUCacheTest.new.test_put_remove_with_capacity_of_one
LRUCacheTest.new.test_put_remove_with_repeated_keys
LRUCacheTest.new.test_put_remove_with_multiple_repeated_keys
LRUCacheTest.new.long_test
p 'all tests passed!'
