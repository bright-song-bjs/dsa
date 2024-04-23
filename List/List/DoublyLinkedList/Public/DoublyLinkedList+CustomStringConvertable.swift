extension DoublyLinkedList: CustomStringConvertible {
  public var description: String {
    guard !isEmpty else {
      return "Empty Doubly Linked List"
    }
    let s1 = "Doubly Linked List: "
    let s2 = map { "\($0)" }.joined(separator: "---")
    return s1 + s2
  }
}
