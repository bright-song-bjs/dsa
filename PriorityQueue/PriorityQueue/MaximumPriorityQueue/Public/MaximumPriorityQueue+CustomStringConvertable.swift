extension MaximumPriorityQueue {
  public var description: String {
    guard !isEmpty else {
      return "Empty Maximum Priority Queue"
    }
    var copy = self
    var elements: [Element] = []
    elements.reserveCapacity(copy.count)
    while let element = copy.dequeue() {
      elements.append(element)
    }
    
    let s1 = "Maximum Priority Queue: front-> "
    let s2 = elements.map { "\($0)" }.joined(separator: "---")
    let s3 = " <-back"
    return s1 + s2 + s3
  }
}

