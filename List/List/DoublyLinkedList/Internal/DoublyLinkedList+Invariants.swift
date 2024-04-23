extension DoublyLinkedList {
  @inlinable @inline(__always)
  func checkInvariants() {
    assert(tail?.next == nil)
    assert(head?.prev == nil)
  }
}
