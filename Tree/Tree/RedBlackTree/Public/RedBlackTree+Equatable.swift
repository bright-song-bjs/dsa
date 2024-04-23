extension RedBlackTree: Equatable {
  @inlinable @inline(__always)
  public static func == (lhs: Self, rhs: Self) -> Bool {
    _isEqual(lhs.root, rhs.root)
  }
}
