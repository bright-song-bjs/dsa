extension RedBlackTree: CustomStringConvertible {
  public var description: String {
    guard let root = root else {
      return "Empty Red Black Tree"
    }
    let s1 = "Red Black Tree:\n"
    let s2 = String(repeating: "-", count: 15) + "\n\n"
    let s3 = _description(for: root)
    let s4 = "\n" + String(repeating: "-", count: 15)
    return s1 + s2 + s3 + s4
  }
}
