extension Array where Element == Int {
  public mutating func lexicographicalSort() {
    let sorted = lexicographicalSorted()
    self = sorted
  }
  
  public func lexicographicalSorted() -> Self {
    let positive = filter { $0 >= 0 }
    return lexicographicalSort(
      positive,
      at: 0,
      maxDigitCount: (positive.max()?.digitCount ?? 0)
    )
  }
  
  private func lexicographicalSort(
    _ elements: Self,
    at position: Int,
    maxDigitCount: Int
  ) -> Self {
    guard position < maxDigitCount else {
      return elements
    }
    var buckets: [[Int]] = .init(repeating: [], count: 10)
    var result: [Int] = []
    result.reserveCapacity(elements.count)
    
    for number in elements {
      if let digit = number.digitFromLeft(at: position) {
        buckets[digit].append(number)
      } else {
        result.append(number)
      }
    }
    for bucket in buckets {
      if !bucket.isEmpty {
        result.append(contentsOf: lexicographicalSort(
          bucket,
          at: position + 1,
          maxDigitCount: maxDigitCount
        ))
      }
    }
    return result
  }
}
