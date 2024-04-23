public protocol BinaryTree {
  associatedtype Element: Comparable
  
  var orderedElements: [Element] { get }
  
  func contains(_ element: Element) -> Bool
  
  mutating func insert(_ newElement: Element)
  
  @discardableResult
  mutating func remove(_ element: Element) -> Element?
}
