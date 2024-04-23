extension AdjacencyMatrixGraph {
  @usableFromInline
  final class Storage {
    @usableFromInline
    var indexByNode: [Node<Element>: Int]
    
    @usableFromInline
    var connections: [[Connection?]]
    
    @inlinable @inline(__always)
    init(
      indexByNode: [Node<Element>: Int],
      connections: [[Connection?]]
    ) {
      self.indexByNode = indexByNode
      self.connections = connections
    }
  }
}
