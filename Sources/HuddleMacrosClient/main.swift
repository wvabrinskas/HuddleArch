import HuddleMacros
import HuddleArch

final class ObjectA {
  
}

final class ObjectB {
  
}

final class ObjectC {
  
}

protocol RootComponent: Component {
  var objectA: ObjectA { get }
  var objectB: ObjectB { get }
  var objectC: ObjectC { get }
}

//#ComponentImplFree(RootComponent)

@ComponentImpl
final class RootComponentImpl: Component, RootComponent {
  var objectA: ObjectA
  var objectB: ObjectB
  var objectC: ObjectC
}

protocol FirstSubComponent: Component {
  var objectA: ObjectA { get }
}
