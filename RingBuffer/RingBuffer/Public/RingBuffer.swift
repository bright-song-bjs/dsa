public struct RingBuffer<Element> {
  @usableFromInline
  var storage: [Element?]
  
  @usableFromInline
  var popIndex = 0
  
  @usableFromInline
  var pushIndex = 0
  
  @inlinable @inline(__always)
  public init(capacity: Int) {
    storage = Array(repeating: nil, count: capacity)
  }
}

extension RingBuffer {
  @inlinable @inline(__always)
  public var count: Int {
    pushIndex - popIndex
  }
  
  @inlinable @inline(__always)
  public var capacity: Int {
    storage.count
  }
  
  @inlinable @inline(__always)
  public var isEmpty: Bool {
    count == 0
  }
  
  @inlinable @inline(__always)
  public var isFull: Bool {
    count >= capacity
  }
  
  @inlinable @inline(__always)
  public var start: Element? {
    isEmpty ? nil : storage[wrapped: pushIndex - 1]
  }
  
  @inlinable @inline(__always)
  public var end: Element? {
    isEmpty ? nil : storage[wrapped: popIndex]
  }
  
  @inlinable @inline(__always)
  public mutating func write(_ newElement: Element) {
    precondition(!isFull)
    storage[wrapped: pushIndex] = newElement
    pushIndex += 1
  }
  
  @inlinable
  public mutating func read() -> Element? {
    guard !isEmpty else {
      return nil
    }
    let removedElement = storage[wrapped: popIndex]
    popIndex += 1
    resetIndex()
    return removedElement
  }
  
  @inlinable
  public mutating func resetCapacity(_ newCapacity: Int) {
    let count = count
    precondition(newCapacity >= count)
    var newStorage: [Element?] = []
    newStorage.reserveCapacity(newCapacity)
    for i in 0..<count {
      newStorage[i] = storage[wrapped: popIndex + i]
    }
    storage = newStorage
    popIndex = 0
    pushIndex = count
  }
}
