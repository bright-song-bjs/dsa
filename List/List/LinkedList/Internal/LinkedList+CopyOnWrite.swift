extension LinkedList {
  @inlinable @inline(__always)
  mutating func update() {
    _update(withIndex: nil)
  }
  
  @inlinable @inline(__always)
  mutating func update(
    withIndex index: Index
  ) -> Index {
    guard let updatedIndex =  _update(withIndex: index) else {
      preconditionFailure()
    }
    return updatedIndex
  }
  
  @usableFromInline
  @discardableResult
  mutating func _update(
    withIndex index: Index?
  ) -> Index? {
    guard
      !isKnownUniquelyReferenced(&head),
      var currOldNode = head
    else {
      return index
    }
    var currNewNode = Node(value: currOldNode.value)
    head = currNewNode
    var updatedIndex: Index?
    if currOldNode === index?.node {
      updatedIndex = Index(node: currNewNode)
    }
    
    while let nextOldNode = currOldNode.next {
      let newNode = Node(value: nextOldNode.value)
      currNewNode.next = newNode
      currOldNode = nextOldNode
      currNewNode = newNode
      if currOldNode === index?.node {
        updatedIndex = Index(node: currNewNode)
      }
    }
    tail = currNewNode
    return updatedIndex
  }
}
