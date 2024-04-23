extension DoublyLinkedList {
  @inlinable @inline(__always)
  mutating func update() {
    _update(withFirstIndex: nil, withSecondIndex: nil)
  }
  
  @inlinable @inline(__always)
  mutating func update(
    withIndex index: Index
  ) -> Index {
    let updated = _update(withFirstIndex: index, withSecondIndex: nil)
    guard let firstIndex = updated.firstIndex else {
      preconditionFailure()
    }
    return firstIndex
  }
  
  @inlinable @inline(__always)
  mutating func update(
    withRange range: Range<Index>
  ) -> Range<Index> {
    let updated = _update(
      withFirstIndex: range.lowerBound,
      withSecondIndex: range.upperBound
    )
    guard
      let lowerBound = updated.firstIndex,
      let upperBound = updated.secondIndex
    else {
      preconditionFailure()
    }
    return lowerBound..<upperBound
  }
  
  @usableFromInline
  @discardableResult
  mutating func _update(
    withFirstIndex firstIndex: Index?,
    withSecondIndex secondIndex: Index?
  ) -> (firstIndex: Index?, secondIndex: Index?) {
    guard
      !isKnownUniquelyReferenced(&head),
      var currOldNode = head
    else {
      return (firstIndex, secondIndex)
    }
    var currNewNode = Node(value: currOldNode.value)
    head = currNewNode
    var firstUpdatedIndex: Index?
    var secondUpdatedIndex: Index?
    if currOldNode === firstIndex?.node {
      firstUpdatedIndex = Index(node: currNewNode)
    }
    if currOldNode === secondIndex?.node {
      secondUpdatedIndex = Index(node: currNewNode)
    }
    
    while let nextOldNode = currOldNode.next {
      let newNode = Node(
        value: nextOldNode.value,
        prev: currNewNode
      )
      currNewNode.next = newNode
      currOldNode = nextOldNode
      currNewNode = newNode
      if currOldNode === firstIndex?.node {
        firstUpdatedIndex = Index(node: currNewNode)
      }
      if currOldNode === secondIndex?.node {
        secondUpdatedIndex = Index(node: currNewNode)
      }
    }
    tail = currNewNode
    return (firstUpdatedIndex, secondUpdatedIndex)
  }
}
