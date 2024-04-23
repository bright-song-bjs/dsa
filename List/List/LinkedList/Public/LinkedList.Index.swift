extension LinkedList {
  public struct Index: Comparable {
    @usableFromInline
    weak var node: Node?
    
    @inlinable @inline(__always)
    init(node: Node?) {
      self.node = node
    }
    
    @inlinable @inline(__always)
    public static func == (lhs: Self, rhs: Self) -> Bool {
      switch (lhs.node, rhs.node) {
      case let (leftNode?, rightNode?):
        return leftNode === rightNode
      case (nil, nil):
        return true
      default:
        return false
      }
    }
    
    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
      guard var currNode = lhs.node else {
        return false
      }
      if rhs.node == nil {
        return true
      }
      while let nextNode = currNode.next {
        if nextNode === rhs.node {
          return true
        }
        currNode = nextNode
      }
      return false
    }
  }
}
