extension LinkedList {
  @inlinable
  public mutating func breakIntoUnsafeNodes() -> [UnsafeNode] {
    update()
    var result: [UnsafeNode] = []
    var currNode = head
    while let node = currNode {
      result.append(UnsafeNode(node))
      currNode = node.next
      node.next = nil
    }
    head = nil
    tail = nil
    checkInvariants()
    return result
  }
  
  @inlinable
  public init(unsafeNodes: [UnsafeNode]) {
    guard let firstUnsafeNode = unsafeNodes.first else {
      return
    }
    head = firstUnsafeNode.storage
    var currNode = firstUnsafeNode.storage
    for unsafeNode in unsafeNodes.dropFirst() {
      currNode.next = unsafeNode.storage
      currNode = unsafeNode.storage
    }
    tail = currNode
    checkInvariants()
  }
}
