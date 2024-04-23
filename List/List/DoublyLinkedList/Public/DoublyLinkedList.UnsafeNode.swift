extension DoublyLinkedList {
  public struct UnsafeNode {
    @usableFromInline
    var storage: Node
    
    @inlinable @inline(__always)
    init(_ node: Node) {
      storage = node
    }
    
    @inlinable @inline(__always)
    public var value: Element {
      storage.value
    }
  }
}
