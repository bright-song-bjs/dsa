public protocol Queue {
  associatedtype Element
  
  var isEmpty: Bool { get }
  
  var count: Int { get }
  
  var front: Element? { get }
  
  mutating func enqueue(_ newElement: Element)
  
  mutating func dequeue() -> Element?
}

