extension Array where Element == Int {
  public mutating func radixSort() {
    let sorted = radixSorted()
    self = sorted
  }
  
  public func radixSorted() -> Self {
    var positive: [Element] = []
    positive.reserveCapacity(count)
    var negative: [Element] = []
    negative.reserveCapacity(count)
    for element in self {
      if element < 0 {
        negative.append(element)
      } else {
        positive.append(element)
      }
    }
    var base = 1
    for _ in 0..<(positive.max()?.digitCount ?? 0) {
      var buckets: [[Int]] = .init(repeating: [], count: 10)
      for number in positive {
        let remain = number / base
        let digit = remain / 10
        buckets[digit].append(number)
      }
      base *= 10
      positive = buckets.flatMap { $0 }
    }
    base = 1
    for _ in 0..<(negative.min()?.digitCount ?? 0) {
      var buckets: [[Int]] = .init(repeating: [], count: 10)
      for number in negative {
        let remain = number / base
        let digit = remain / 10
        buckets[digit + 9].append(number)
      }
      base *= 10
      negative = buckets.flatMap { $0 }
    }
    return negative + positive
  }
}
