extension MutableCollection {
  public mutating func bubbleSort(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) {
    for upperIndex in indices.reversed() {
      var swapped = false
      var currIndex = startIndex
      while currIndex < upperIndex {
        let nextIndex = index(after: currIndex)
        if areInAscendingOrder(self[nextIndex], self[currIndex]) {
          swapAt(currIndex, nextIndex)
          swapped = true
        }
        currIndex = nextIndex
      }
      if !swapped {
        return
      }
    }
  }
  
  public func bubbleSorted(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) -> Self {
    var copy = self
    copy.bubbleSort(by: areInAscendingOrder)
    return copy
  }
}
