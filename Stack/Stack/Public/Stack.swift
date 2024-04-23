public struct Stack<Element> {
  @usableFromInline
  var storage: [Element] = []
  
  @inlinable @inline(__always)
  public init() {}
}

extension Stack {
  @inlinable @inline(__always)
  public var isEmpty: Bool {
    storage.isEmpty
  }
  
  @inlinable @inline(__always)
  public var count: Int {
    storage.count
  }
  
  @inlinable @inline(__always)
  public var top: Element? {
    storage.last
  }
  
  @inlinable @inline(__always)
  public mutating func push(_ newElement: Element) {
    storage.append(newElement)
  }
  
  @inlinable @inline(__always)
  public mutating func pop() -> Element? {
    storage.popLast()
  }
}
