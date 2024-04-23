extension DoublyLinkedList: RangeReplaceableCollection {
  public mutating func replaceSubrange<C>(
    _ subrange: Range<Index>,
    with newElements: C
  ) where C : Collection, Element == C.Element {
    let subrange = update(withRange: subrange)
    let lowerBound = subrange.lowerBound
    let upperBound = subrange.upperBound
    precondition(lowerBound <= upperBound)
    precondition(lowerBound >= startIndex)
    precondition(upperBound <= endIndex)
    let startNode = index(before: lowerBound).node
    let endNode = upperBound.node
    
    guard let firstElement = newElements.first else {
      switch (startNode, endNode) {
      case let (startNode?, endNode?):
        startNode.next = endNode
        endNode.prev = startNode
      case let (startNode?, nil):
        startNode.next = nil
        tail = startNode
      case let (nil, endNode?):
        endNode.prev = nil
        head = endNode
      case (nil, nil):
        head = nil
        tail = nil
      }
      return
    }
    let firstNewNode = Node(value: firstElement)
    var lastNewNode = firstNewNode
    for newElement in newElements.dropFirst() {
      let newNode = Node(value: newElement, prev: lastNewNode)
      lastNewNode.next = newNode
      lastNewNode = newNode
    }
    
    switch (startNode, endNode) {
    case let (startNode?, endNode?):
      startNode.next = firstNewNode
      firstNewNode.prev = startNode
      lastNewNode.next = endNode
      endNode.prev = lastNewNode
    case let (startNode?, nil):
      startNode.next = firstNewNode
      firstNewNode.prev = startNode
      tail = lastNewNode
    case let (nil, endNode?):
      lastNewNode.next = endNode
      endNode.prev = lastNewNode
      head = firstNewNode
    case (nil, nil):
      head = firstNewNode
      tail = lastNewNode
    }
  }
  
  @inlinable @inline(__always)
  @discardableResult
  public mutating func removeFirst() -> Element {
    if let removedElement = popFirst() {
      return removedElement
    } else {
      preconditionFailure()
    }
  }
  
  @inlinable @inline(__always)
  @discardableResult
  public mutating func removeLast() -> Element {
    if let removedElement = popLast() {
      return removedElement
    } else {
      preconditionFailure()
    }
  }
  
  @inlinable @inline(__always)
  public mutating func removeAll(
    keepingCapacity keepCapacity: Bool = false
  ) {
    head = nil
    tail = nil
  }
  
  @inlinable
  public mutating func removeAll(
    where shouldBeRemoved: (Element) throws -> Bool
  ) rethrows {
    update()
    var currIndex = startIndex
    while currIndex < endIndex {
      let nextIndex = index(after: currIndex)
      if try shouldBeRemoved(self[currIndex]) {
        remove(at: currIndex)
      }
      currIndex = nextIndex
    }
  }
}
