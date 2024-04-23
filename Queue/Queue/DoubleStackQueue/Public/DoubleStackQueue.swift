import Stack

// TODO: - As follows
// 1.What is ListQueue's advantages over DoubleStackQueue?
// 2.If there is only one kind of queue, should I rename it to just Queue
//   and rename the protocol to QueueProtocol or something?
// 3.If the Queue protocol is renamed to QueueProtocol, then other
//   protocols should also be renamed like GraphProtocol

public struct DoubleStackQueue<Element> {
  @usableFromInline
  var enqueueStack = Stack<Element>()
  
  @usableFromInline
  var dequeueStack = Stack<Element>()
  
  @inlinable @inline(__always)
  public init() {}
}

extension DoubleStackQueue: Queue {
  @inlinable @inline(__always)
  public var isEmpty: Bool {
    enqueueStack.isEmpty && dequeueStack.isEmpty
  }
  
  @inlinable @inline(__always)
  public var count: Int {
    enqueueStack.count + dequeueStack.count
  }
  
  @inlinable
  public var front: Element? {
    if dequeueStack.isEmpty {
      var copy = enqueueStack
      var bottom: Element?
      while let element = copy.pop() {
        bottom = element
      }
      return bottom
    } else {
      return dequeueStack.top
    }
  }
  
  @inlinable @inline(__always)
  public mutating func enqueue(_ newElement: Element) {
    enqueueStack.push(newElement)
  }
  
  @inlinable @inline(__always)
  public mutating func dequeue() -> Element? {
    if dequeueStack.isEmpty {
      while let element = enqueueStack.pop() {
        dequeueStack.push(element)
      }
    }
    return dequeueStack.pop()
  }
}
