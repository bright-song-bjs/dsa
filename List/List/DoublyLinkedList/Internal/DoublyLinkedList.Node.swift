extension DoublyLinkedList {
  @usableFromInline
  final class Node {
    @usableFromInline
    var value: Element
    
    @usableFromInline
    var next: Node?
    
    @usableFromInline
    weak var prev: Node?
    
    @inlinable @inline(__always)
    init(
      value: Element,
      next: Node? = nil,
      prev: Node? = nil
    ) {
      self.value = value
      self.next = next
      self.prev = prev
    }
  }
}
