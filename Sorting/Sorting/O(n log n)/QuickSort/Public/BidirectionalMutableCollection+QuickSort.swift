extension MutableCollection where Self: BidirectionalCollection {
  public mutating func quickSort(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) {
    quickSort(in: startIndex..<endIndex, by: areInAscendingOrder)
  }
  
  public func quickSorted(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) -> Self {
    var copy = self
    copy.quickSort(by: areInAscendingOrder)
    return copy
  }
  
  private mutating func quickSort(
    in subrange: Range<Index>,
    by areInAscendingOrder: (Element, Element) -> Bool
  ) {
    let lowerBound = subrange.lowerBound
    let upperBound = subrange.upperBound
    let distance = distance(from: lowerBound, to: upperBound)
    guard distance > 1 else {
      return
    }
    
    let middleIndex = index(lowerBound, offsetBy: distance / 2)
    var pivot = self[middleIndex]
    let lowerElement = self[lowerBound]
    if areInAscendingOrder(pivot, lowerElement) {
      pivot = lowerElement
    }
    let upperElement = self[index(before: upperBound)]
    if areInAscendingOrder(upperElement, pivot) {
      pivot = upperElement
    }
    
    let partitionIndex = partition(
      from: pivot,
      in: subrange,
      by: areInAscendingOrder
    )
    quickSort(in: lowerBound..<partitionIndex, by: areInAscendingOrder)
    quickSort(in: partitionIndex..<upperBound, by: areInAscendingOrder)
  }
  
  private mutating func partition(
    from pivot: Element,
    in subrange: Range<Index>,
    by areInAscendingOrder: (Element, Element) -> Bool
  ) -> Index {
    var lowerIndex = index(before: subrange.lowerBound)
    var upperIndex = subrange.upperBound
    while true {
      repeat {
        formIndex(after: &lowerIndex)
      } while areInAscendingOrder(self[lowerIndex], pivot)
      
      repeat {
        formIndex(before: &upperIndex)
      } while areInAscendingOrder(pivot, self[upperIndex])
      
      if lowerIndex < upperIndex {
        swapAt(lowerIndex, upperIndex)
      } else {
        return lowerIndex
      }
    }
  }
}

