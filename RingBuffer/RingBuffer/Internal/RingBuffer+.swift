extension RingBuffer {
  @inlinable @inline(__always)
  mutating func resetIndex() {
    if isEmpty {
      pushIndex = 0
      popIndex = 0
    }
  }
}
