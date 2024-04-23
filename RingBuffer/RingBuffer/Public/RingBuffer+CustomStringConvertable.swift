extension RingBuffer: CustomStringConvertible {
  public var description: String {
    guard !isEmpty else {
      return "Empty Ring Buffer"
    }
    let s1 = "Ring Buffer: end-> "
    let s2 = map { "\($0)" }.joined(separator: "---")
    let s3 = " <-start"
    return s1 + s2 + s3
  }
}

