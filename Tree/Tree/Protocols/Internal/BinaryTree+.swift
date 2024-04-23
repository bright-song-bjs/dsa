extension BinaryTree {
  @usableFromInline
  func _inOrderTraverse<T: BinaryNode>(
    from node: T?,
    result: inout [Element]
  ) where T.Value == Element {
    guard let node = node else {
      return
    }
    _inOrderTraverse(from: node.leftChild, result: &result)
    result.append(node.value)
    _inOrderTraverse(from: node.rightChild, result: &result)
  }
  
  @usableFromInline
  static func _isEqual<T: BinaryNode>(
    _ lhs: T?,
    _ rhs: T?
  ) -> Bool where T.Value == Element {
    switch (lhs, rhs) {
    case (nil, nil):
      return true
    case let (lhs?, rhs?):
      let b1 = lhs.value == rhs.value
      let b2 = _isEqual(lhs.leftChild, rhs.leftChild)
      let b3 = _isEqual(lhs.rightChild, rhs.rightChild)
      return b1 && b2 && b3
    default:
      return false
    }
  }
  
  func _description<T: BinaryNode>(
    for node: T?,
    top: String = "",
    root: String = "",
    bottom: String = ""
  ) -> String where T.Value == Element {
    guard let node = node else {
      return root + "nil\n"
    }
    if node.leftChild == nil, node.rightChild == nil {
      return root + "\(node.value)\n"
    } else {
      let s1 = _description(
        for: node.rightChild,
        top: top + " ",
        root: top + "┌──",
        bottom: top + "│ "
      )
      let s2 = root + "\(node.value)\n"
      let s3 = _description(
        for: node.leftChild,
        top: bottom + "│ ",
        root: bottom + "└──",
        bottom: bottom + " "
      )
      return s1 + s2 + s3
    }
  }
  
  @usableFromInline
  func _duplicate<T: BinaryNode>(_ node: T) -> T {
    var newNode = T(duplicating: node)
    if let leftChild = node.leftChild {
      newNode.leftChild = _duplicate(leftChild)
    }
    if let rightChild = node.rightChild {
      newNode.rightChild = _duplicate(rightChild)
    }
    return newNode
  }
}
