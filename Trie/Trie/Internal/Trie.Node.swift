extension Trie {
  @usableFromInline
  final class Node {
    @usableFromInline
    var children: [CollectionType.Element: Node] = [:]
    
    @usableFromInline
    var isTerminating = false
    
    @inlinable @inline(__always)
    init() {}
  }
}
