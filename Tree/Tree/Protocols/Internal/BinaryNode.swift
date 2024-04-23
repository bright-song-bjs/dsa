@usableFromInline
protocol BinaryNode {
  associatedtype Value
  
  var value: Value { get set }
  
  var leftChild: Self? { get set }
  
  var rightChild: Self? { get set }
  
  init(duplicating node: Self)
}
