extension RingBuffer: Equatable where Element: Equatable {
  @inlinable
  public static func == (lhs: Self, rhs: Self) -> Bool {
    if lhs.count == rhs.count {
      for (leftElement, rightElement) in zip(lhs, rhs) {
        if leftElement != rightElement {
          return false
        }
      }
      return true
    } else {
      return false
    }
  }
}
