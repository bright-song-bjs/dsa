extension AdjacencyMatrixGraph {
  @usableFromInline
  struct Connection {
    @usableFromInline
    let weight: Double?
    
    @inlinable @inline(__always)
    init(weight: Double?) {
      self.weight = weight
    }
  }
}
