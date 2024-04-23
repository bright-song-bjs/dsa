import Heap

extension Array {
  public mutating func heapSort(
    by areInAscendingOrder: @escaping (Element, Element) -> Bool
  ) {
    let sorted = heapSorted(by: areInAscendingOrder)
    self = sorted
  }
  
  public func heapSorted(
    by areInAscendingOrder: @escaping (Element, Element) -> Bool
  ) -> Self {
    var elements = Heap(self, orderedBy: areInAscendingOrder)
    var result: [Element] = []
    result.reserveCapacity(elements.count)
    while let element = elements.popMin() {
      result.append(element)
    }
    return result
  }
}
