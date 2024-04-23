extension RedBlackTree {
  func leftRotate(_ node: Node) -> Node {
    guard let pivot = node.rightChild else {
      return node
    }
    node.rightChild = pivot.leftChild
    pivot.leftChild = node
    return pivot
  }
  
  func rightRotate(_ node: Node) -> Node {
    guard let pivot = node.leftChild else {
      return node
    }
    node.leftChild = pivot.rightChild
    pivot.rightChild = node
    return pivot
  }
  
  func rightLeftRotate(_ node: Node) -> Node {
    guard let rightChild = node.rightChild else {
      return node
    }
    node.rightChild = rightRotate(rightChild)
    return leftRotate(node)
  }
  
  func leftRightRotate(_ node: Node) -> Node {
    guard let leftChild = node.leftChild else {
      return node
    }
    node.leftChild = leftRotate(leftChild)
    return rightRotate(node)
  }
  
  @usableFromInline
  func _insert(
    _ newElement: Element,
    from node: Node?,
    siblingColor: Node.Color?
  ) -> (newNode: Node, state: InsertionState) {
    guard let node = node else {
      let newNode = Node(
        value: newElement,
        color: siblingColor == nil ? .black : .red
      )
      return (newNode, .shouldCheck)
    }
    let insertionState: InsertionState
    let childBranchDirection: BranchDirection
    if newElement < node.value {
      (node.leftChild, insertionState) = _insert(
        newElement,
        from: node.leftChild,
        siblingColor: node.rightChild?.color ?? .black
      )
      childBranchDirection = .left
    } else {
      (node.rightChild, insertionState) = _insert(
        newElement,
        from: node.rightChild,
        siblingColor: node.leftChild?.color ?? .black
      )
      childBranchDirection = .right
    }
    
    switch insertionState {
    case .shouldCheck:
      if node.color == .black {
        return (node, .shouldContinue)
      } else {
        guard let siblingColor = siblingColor else {
          preconditionFailure()
        }
        if siblingColor == .black {
          switch childBranchDirection {
          case .left:
            let state = InsertionState.shouldRotate(
              grandchildBranchDirection: .left
            )
            return (node, state)
          case .right:
            let state = InsertionState.shouldRotate(
              grandchildBranchDirection: .right
            )
            return (node, state)
          }
        } else {
          return (node, .shouldColorChildrenToBlack)
        }
      }
    case .shouldColorChildrenToBlack:
      node.leftChild?.color = .black
      node.rightChild?.color = .black
      if siblingColor != nil {
        node.color = .red
      }
      return (node, .shouldCheck)
    case let .shouldRotate(grandchildBranchDirection):
      let newNode: Node
      switch (childBranchDirection, grandchildBranchDirection) {
      case (.left, .left):
        newNode = rightRotate(node)
      case (.right, .right):
        newNode = leftRotate(node)
      case (.left, .right):
        newNode = leftRightRotate(node)
      case (.right, .left):
        newNode = rightLeftRotate(node)
      }
      node.color = .red
      newNode.color = .black
      return (newNode, .shouldContinue)
    case .shouldContinue:
      return (node, .shouldContinue)
    }
  }
  
  @usableFromInline
  func _remove(
    _ element: Element,
    from node: Node?,
    result: inout Element?
  ) -> Node? {
    // FIXME: Implementation
    guard let node = node else {
      return nil
    }
    if element < node.value {
      
    } else if element == node.value {
      result = element
      switch (node.leftChild, node.rightChild) {
      case let (_?, rightChild?):
        print(rightChild.value)
      case let (leftChild?, nil):
        return leftChild
      case let (nil, rightChild?):
        return rightChild
      case (nil, nil):
        return nil
      }
    } else {
      
    }
    return node
  }
}
