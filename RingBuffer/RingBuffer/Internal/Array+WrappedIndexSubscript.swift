extension Array {
  @inlinable @inline(__always)
  subscript (wrapped index: Int) -> Element {
    get { self[index % self.count] }
    set { self[index % self.count] = newValue }
  }
}
