extension AVLTree {
  @inlinable @inline(__always)
  mutating func update() {
    guard
      !isKnownUniquelyReferenced(&root),
      let root = root
    else {
      return
    }
    self.root = _duplicate(root)
  }
}
