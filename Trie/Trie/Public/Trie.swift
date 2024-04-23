import Stack

public struct Trie<
  CollectionType: Collection
> where CollectionType.Element: Hashable {
  @usableFromInline
  var root = Node()
  
  @inlinable @inline(__always)
  public init() {}
}

extension Trie {
  @inlinable @inline(__always)
  public var isEmpty: Bool {
    count == 0
  }
  
  @inlinable @inline(__always)
  public var count: Int {
    var result = 0
    _count(from: root, result: &result)
    return result
  }
  
  @inlinable
  public mutating func insert(_ newCollection: CollectionType) {
    update()
    var currNode = root
    for newElement in newCollection {
      if currNode.children[newElement] == nil {
        currNode.children[newElement] = Node()
      }
      currNode = currNode.children[newElement]!
    }
    currNode.isTerminating = true
  }
  
  @inlinable
  public func contains(_ collection: CollectionType) -> Bool {
    var currNode = root
    for element in collection {
      if let child = currNode.children[element] {
        currNode = child
      } else {
        return false
      }
    }
    return currNode.isTerminating
  }
  
  @inlinable
  @discardableResult
  public mutating func remove(
    _ collection: CollectionType
  ) -> CollectionType? {
    update()
    var currNode = root
    var tracked = Stack<(
      key: CollectionType.Element,
      parentNode: Node
    )>()
    for element in collection {
      if let child = currNode.children[element] {
        tracked.push((element, currNode))
        currNode = child
      } else {
        return nil
      }
    }
    
    guard currNode.isTerminating else {
      return nil
    }
    currNode.isTerminating = false
    while let (key, parentNode) = tracked.pop() {
      guard
        currNode.children.isEmpty,
        !currNode.isTerminating
      else {
        break
      }
      currNode = parentNode
      currNode.children[key] = nil
    }
    return collection
  }
}

extension Trie where CollectionType: RangeReplaceableCollection {
  @inlinable @inline(__always)
  public var collections: [CollectionType] {
    collections(startingWith: .init())
  }
  
  @inlinable
  public func collections(
    startingWith possiblePrefix: CollectionType
  ) -> [CollectionType] {
    var result: [CollectionType] = []
    var currNode = root
    for element in possiblePrefix {
      if let child = currNode.children[element] {
        currNode = child
      } else {
        return result
      }
    }
    _collections(
      possibleCollection: possiblePrefix,
      after: currNode,
      result: &result
    )
    return result
  }
}
