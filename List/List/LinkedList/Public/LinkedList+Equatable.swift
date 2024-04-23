extension LinkedList: Equatable where Element: Equatable {
  @inlinable
  public static func == (lhs: Self, rhs: Self) -> Bool {
    var currLeftNode = lhs.head
    var currRightNode = rhs.head
    while true {
      switch (currLeftNode, currRightNode) {
      case let (leftNode?, rightNode?):
        if leftNode.value != rightNode.value {
          return false
        }
        currLeftNode = leftNode.next
        currRightNode = rightNode.next
      case (nil, nil):
        return true
      default:
        return false
      }
    }
  }
}
