import HuddleMacros
import HuddleArch

final class ObjectA {
  
}

final class ObjectB {
  
}

final class ObjectC {
  
}

final class ObjectD {}

protocol MainComponent: Component {
  var objectA: ObjectA { get }
  var objectB: ObjectB { get }
  var objectC: ObjectC { get }
  var objectD: ObjectD { get }
  var objectJ: ObjectA { get }
  var subComponent: SubComponent { get }
}

//#ComponentImplFree(RootComponent)

protocol SubComponent: Component {
  var objectA: ObjectA { get }
}

@ComponentImpl
final class SubComponentImpl: Component, SubComponent {
  var objectA: ObjectA
}

@ComponentImpl
final class MainComponentImpl: Component, MainComponent {
  var objectA: ObjectA
  var objectB: ObjectB
  var objectC: ObjectC
  var objectD: ObjectD
  var objectJ = ObjectA()
  
  var subComponent: SubComponent {
    SubComponentImpl(parent: self)
  }
  
}

final class RootComponent: Component {
  var objectA: ObjectA = .init()
  var objectB: ObjectB = .init()
  var objectC: ObjectC = .init()
  var objectD: ObjectD = .init()
  
  var mainComponent: MainComponent {
    MainComponentImpl(parent: self)
  }
}

let component = RootComponent(parent: EmptyComponent())

print(component.mainComponent)
