extension LinkedList {
  @usableFromInline
  final class Node {
    @usableFromInline
    var value: Element
    
    @usableFromInline
    var next: Node?
    
    @inlinable @inline(__always)
    init(value: Element, next: Node? = nil) {
      self.value = value
      self.next = next
    }
  }
}
