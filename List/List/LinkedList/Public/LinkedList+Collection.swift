extension LinkedList: Collection {
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
  public subscript(index: Index) -> Element {
    get { index.node!.value }
    set { index.node!.value = newValue }
  }
}
