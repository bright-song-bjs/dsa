extension LinkedList {
  @inlinable @inline(__always)
  func checkInvariants() {
    assert(tail?.next == nil)
  }
}
