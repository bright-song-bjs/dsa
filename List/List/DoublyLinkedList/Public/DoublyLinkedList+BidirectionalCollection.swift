extension DoublyLinkedList: BidirectionalCollection {
  @inlinable @inline(__always)
  public var startIndex: Index {
    Index(node: head)
  }
  
  @inlinable @inline(__always)
  public var endIndex: Index {
    Index(node: nil)
  }
  
  @inlinable @inline(__always)
  public func index(after i: Index) -> Index {
    Index(node: i.node?.next)
  }
  
  @inlinable @inline(__always)
  public func index(before i: Index) -> Index {
    if let node = i.node {
      return Index(node: node.prev)
    } else {
      return Index(node: tail)
    }
  }
  
  @inlinable @inline(__always)
  public subscript(index: Index) -> Element {
    get { index.node!.value }
    set { index.node!.value = newValue }
  }
}
