extension Stack: CustomStringConvertible {
  public var description: String {
    guard !isEmpty else {
      return "Empty Stack"
    }
    let s1 = "Stack: bottom-> "
    let s2 = storage.map { "\($0)" }.joined(separator: "---")
    let s3 = " <-top"
    return s1 + s2 + s3
  }
}
