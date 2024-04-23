// TODO: - As follows
// 1.Should I change remove the tail reference, only keeping head? So
//   the append method won't be available anymore
// 2.Should I implement Circular version of LinkedList and
//   DoublyLinkedList? they both require only one reference, tail for
//   LinkedList, head for DoublyLinkedList, but they can't conform to
//   Collection, because there is no endIndex, but conforming to Sequence
//   is fine
// 3.Should I use checkInvariants at all? I don't have to modify the prev
//   property of the node sometimes because it's weak reference, but if
//   there is a checkInvariants at the end of a method, I have to modify
//   the prev and tail to make it work
// 4.Or just delete the LinkedList because it doesn't essentially do
//   anything, and rename DoublyLinkedList to List, and I can optionally
//   implement a CircularList which resembles LinkedList, whose node
//   only has the next property, and conforms to Sequence not Collection


public struct LinkedList<Element> {
  @usableFromInline
  var head: Node?
  
  @usableFromInline
  weak var tail: Node? 
  
  @inlinable @inline(__always)
  public init() {}
  
  @inlinable @inline(__always)
  public init<S>(
    _ elements: S
  ) where S: Sequence, S.Element == Element {
    for element in elements {
      append(element)
    }
  }
}

extension LinkedList {
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
  public var last: Element? {
    guard let tail = tail else {
      return nil
    }
    return tail.value
  }

  @inlinable
  public mutating func prepend(_ newElement: Element) {
    update()
    let newNode = Node(value: newElement, next: head)
    head = newNode
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
    let newNode = Node(value: newElement)
    tail.next = newNode
    self.tail = newNode
    checkInvariants()
  }

  @inlinable
  public mutating func insert(
    _ newElement: Element,
    after index: Index
  ) {
    guard let node = update(withIndex: index).node else {
      preconditionFailure()
    }
    if node === tail {
      return append(newElement)
    } else {
      let newNode = Node(value: newElement, next: node.next)
      node.next = newNode
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
    if self.head == nil {
      tail = nil
    }
    checkInvariants()
    return removedElement
  }

  @inlinable
  @discardableResult
  public mutating func remove(
    after index: Index
  ) -> Element {
    guard
      let node = update(withIndex: index).node,
      let nextNode = node.next
    else {
      preconditionFailure()
    }
    let removedElement = nextNode.value
    if nextNode === tail {
      tail = node
    }
    node.next = nextNode.next
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
    while currNode != nil {
      let nextNode = currNode?.next
      currNode?.next = prevNode
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
