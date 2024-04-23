import Heap
import Queue

public struct MinimumPriorityQueue<Element> {
  @usableFromInline
  var storage: Heap<Element>
  
  @inlinable @inline(__always)
  public init(
    orderedBy areInAscendingOrder:
      @escaping (Element, Element) -> Bool
  ) {
    storage = Heap(orderedBy: areInAscendingOrder)
  }
}

extension MinimumPriorityQueue: Queue {
  @inlinable @inline(__always)
  public var isEmpty: Bool {
    storage.isEmpty
  }
  
  @inlinable @inline(__always)
  public var count: Int {
    storage.count
  }
  
  @inlinable @inline(__always)
  public var front: Element? {
    storage.min
  }
  
  @inlinable @inline(__always)
  public mutating func enqueue(_ newElement: Element) {
    storage.insert(newElement)
  }
  
  @inlinable @inline(__always)
  public mutating func dequeue() -> Element? {
    storage.popMin()
  }
}
