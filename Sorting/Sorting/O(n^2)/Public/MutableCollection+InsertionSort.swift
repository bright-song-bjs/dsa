extension MutableCollection {
  public mutating func insertionSort(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) {
    let reversedIndices = indices.reversed()
    guard let upperIndex = reversedIndices.first else {
      return
    }
    for lowerIndex in reversedIndices.dropFirst() {
      var currIndex = lowerIndex
      while currIndex < upperIndex {
        let nextIndex = index(after: currIndex)
        if areInAscendingOrder(self[nextIndex], self[currIndex]) {
          swapAt(nextIndex, currIndex)
        } else {
          break
        }
        currIndex = nextIndex
      }
    }
  }
  
  public func insertionSorted(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) -> Self {
    var copy = self
    copy.insertionSort(by: areInAscendingOrder)
    return copy
  }
}
