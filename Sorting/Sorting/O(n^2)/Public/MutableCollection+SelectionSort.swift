extension MutableCollection {
  public mutating func selectionSort(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) {
    for lowerIndex in indices {
      var candidate = lowerIndex
      var currIndex = index(after: lowerIndex)
      while currIndex < endIndex {
        if areInAscendingOrder(self[currIndex], self[candidate]) {
          candidate = currIndex
        }
        formIndex(after: &currIndex)
      }
      if candidate != lowerIndex {
        swapAt(candidate, lowerIndex)
      }
    }
  }
  
  public func selectionSorted(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) -> Self {
    var copy = self
    copy.selectionSort(by: areInAscendingOrder)
    return copy
  }
}
