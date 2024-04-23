extension DoubleStackQueue: Equatable where Element: Equatable {
  @inlinable
  public static func == (lhs: Self, rhs: Self) -> Bool {
    if lhs.count == rhs.count {
      if lhs.enqueueStack.count == rhs.enqueueStack.count {
        let b1 = lhs.enqueueStack == rhs.enqueueStack
        let b2 = lhs.dequeueStack == rhs.dequeueStack
        return b1 && b2
      } else {
        var leftCopy = lhs
        var rightCopy = rhs
        var leftElements: [Element] = []
        var rightElements: [Element] = []
        while let element = leftCopy.dequeue() {
          leftElements.append(element)
        }
        while let element = rightCopy.dequeue() {
          rightElements.append(element)
        }
        return leftElements == rightElements
      }
    } else {
      return false
    }
  }
}
