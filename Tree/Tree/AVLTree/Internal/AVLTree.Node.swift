extension AVLTree {
  @usableFromInline
  final class Node: BinaryNode {
    @usableFromInline
    var value: Element
    
    @usableFromInline
    var leftChild: Node?
    
    @usableFromInline
    var rightChild: Node?
    
    @usableFromInline
    private(set) var height: Int
    
    @inlinable @inline(__always)
    init(value: Element, height: Int = 0) {
      self.value = value
      self.height = height
    }
    
    @inlinable @inline(__always)
    init(duplicating node: Node) {
      value = node.value
      height = node.height
    }
    
    @inlinable @inline(__always)
    var leftHeight: Int {
      leftChild?.height ?? -1
    }
    
    @inlinable @inline(__always)
    var rightHeight: Int {
      rightChild?.height ?? -1
    }
    
    @inlinable @inline(__always)
    var balanceFactor: Int {
      leftHeight - rightHeight
    }
    
    @inlinable @inline(__always)
    func updateHeight() {
      height = 1 + max(leftHeight, rightHeight)
    }
  }
}
