extension Trie: Equatable {
  @inlinable @inline(__always)
  public static func == (lhs: Self, rhs: Self) -> Bool {
    _isEqual(lhs.root, rhs.root)
  }
  
  @usableFromInline
  static func _isEqual(_ lhs: Node, _ rhs: Node) -> Bool {
    guard
      lhs.isTerminating == rhs.isTerminating,
      lhs.children.count == rhs.children.count
    else {
      return false
    }
    for (key, child) in lhs.children {
      if let rightChild = rhs.children[key] {
        if !_isEqual(child, rightChild) {
          return false
        }
      } else {
        return false
      }
    }
    return true
  }
}
