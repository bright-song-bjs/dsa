extension RandomAccessCollection where Element: Comparable {
  public func binarySearch(
    for element: Element,
    in range: Range<Index>? = nil
  ) -> Range<Index> {
    let range = range ?? startIndex..<endIndex
    precondition(range.lowerBound < range.upperBound)
    
    var lowerIndex = range.lowerBound
    var upperIndex = range.upperBound
    while lowerIndex < upperIndex {
      let distance = distance(from: lowerIndex, to: upperIndex)
      let middleIndex = index(lowerIndex, offsetBy: distance / 2)
      let middleElement = self[middleIndex]
      if element < middleElement {
        upperIndex = middleIndex
      } else if element == middleElement {
        var matchedLowerIndex = middleIndex
        var matchedUpperIndex = middleIndex
        while matchedLowerIndex != startIndex {
          let prevIndex = index(before: matchedLowerIndex)
          if middleElement == self[prevIndex] {
            matchedLowerIndex = prevIndex
          } else {
            break
          }
        }
        let indexBeforeEndIndex = index(before: endIndex)
        while matchedUpperIndex != indexBeforeEndIndex {
          let nextIndex = index(after: matchedUpperIndex)
          if middleElement == self[nextIndex] {
            matchedUpperIndex = nextIndex
          } else {
            break
          }
        }
        return matchedLowerIndex..<index(after: matchedUpperIndex)
      } else {
        lowerIndex = index(after: middleIndex)
      }
    }
    return lowerIndex..<upperIndex
  }
}
