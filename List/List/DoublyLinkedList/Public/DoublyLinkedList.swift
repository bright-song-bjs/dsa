public struct DoublyLinkedList<Element> {
  @usableFromInline
  var head: Node?
  
  @usableFromInline
  weak var tail: Node?
  
  @inlinable @inline(__always)
  public init() {}
}

extension DoublyLinkedList {
  @inlinable @inline(__always)
  public var isEmpty: Bool {
    head == nil
  }
  
  @inlinable
  public var count: Int {
    var result = 0
    var currNode = head
    while let node = currNode {
      result += 1
      currNode = node.next
    }
    return result
  }
  
  @inlinable
  public mutating func prepend(_ newElement: Element) {
    update()
    let newNode = Node(value: newElement, next: head)
    head = newNode
    newNode.next?.prev = newNode
    if tail == nil {
      tail = newNode
    }
    checkInvariants()
  }
  
  @inlinable
  public mutating func append(_ newElement: Element) {
    update()
    guard let tail = tail else {
      prepend(newElement)
      return
    }
    let newNode = Node(value: newElement, prev: tail)
    tail.next = newNode
    self.tail = newNode
    checkInvariants()
  }
  
  @inlinable
  public mutating func insert(
    _ newElement: Element,
    at index: Index
  ) {
    guard let node = update(withIndex: index).node else {
      preconditionFailure()
    }
    if node === head {
      prepend(newElement)
    } else {
      let newNode = Node(
        value: newElement,
        next: node,
        prev: node.prev
      )
      node.prev?.next = newNode
      node.prev = newNode
      checkInvariants()
    }
  }
  
  @inlinable
  public mutating func popFirst() -> Element? {
    update()
    guard let head = head else {
      return nil
    }
    let removedElement = head.value
    self.head = head.next
    self.head?.prev = nil
    if self.head == nil {
      tail = nil
    }
    checkInvariants()
    return removedElement
  }
  
  @inlinable
  public mutating func popLast() -> Element? {
    update()
    guard let tail = tail, let prevNode = tail.prev else {
      return popFirst()
    }
    let removedElement = tail.value
    self.tail = prevNode
    prevNode.next = nil
    checkInvariants()
    return removedElement
  }
  
  @inlinable
  @discardableResult
  public mutating func remove(
    at index: Index
  ) -> Element {
    guard let node = update(withIndex: index).node else {
      preconditionFailure()
    }
    let removedElement = node.value
    if node === head {
      head = node.next
    }
    if node === tail {
      tail = node.prev
    }
    node.prev?.next = node.next
    node.next?.prev = node.prev
    checkInvariants()
    return removedElement
  }
  
  @inlinable
  public mutating func reverse() {
    update()
    tail = head
    var prevNode = head
    var currNode = head?.next
    prevNode?.next = nil
    prevNode?.prev = currNode
    while currNode != nil {
      let nextNode = currNode?.next
      currNode?.next = prevNode
      currNode?.prev = nextNode
      prevNode = currNode
      currNode = nextNode
    }
    head = prevNode
    checkInvariants()
  }
  
  @inlinable @inline(__always)
  public func reversed() -> Self {
    var reversed = self
    reversed.reverse()
    return reversed
  }
}
