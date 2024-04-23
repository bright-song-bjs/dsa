extension RingBuffer: Sequence {
  @inlinable
  public func makeIterator() -> AnyIterator<Element> {
    var currIndex = popIndex
    let iterator = AnyIterator {
      if currIndex < pushIndex {
        let index = currIndex
        currIndex += 1
        return storage[wrapped: index]
      } else {
        return nil
      }
    }
    return iterator
  }
}

