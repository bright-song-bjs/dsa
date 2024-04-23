extension Trie {
  @inlinable @inline(__always)
  mutating func update() {
    guard !isKnownUniquelyReferenced(&root) else {
      return
    }
    root = _update(withNode: root)
  }
  
  @usableFromInline
  func _update(withNode node: Node) -> Node {
    let newNode = Node()
    newNode.isTerminating = node.isTerminating
    for (key, child) in node.children {
      newNode.children[key] = _update(withNode: child)
    }
    return newNode
  }
}
