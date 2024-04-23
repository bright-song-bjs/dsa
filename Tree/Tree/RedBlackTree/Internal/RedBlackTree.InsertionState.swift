extension RedBlackTree {
  @usableFromInline
  enum InsertionState {
    case shouldContinue
    case shouldCheck
    case shouldColorChildrenToBlack
    case shouldRotate(grandchildBranchDirection: BranchDirection)
  }
}
