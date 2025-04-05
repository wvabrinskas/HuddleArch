import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(HuddleMacrosMacros)
import HuddleMacrosMacros

let testMacros: [String: Macro.Type] = [
  "ComponentImpl": ComponentImplMacro.self,
  "Building": BuildingImplMacro.self,
  "RootComponentImpl": RootComponentImplMacro.self
]
#endif

final class HuddleMacrosTests: XCTestCase {
  
  func test_rootComponentMacro() throws {
#if canImport(HuddleMacrosMacros)
    assertMacroExpansion(
            """
            protocol RootComponent: Component {
              var objectA: ObjectA { get }
              var objectB: ObjectB { get }
              var objectC: ObjectC { get }
            }
            
            @RootComponentImpl
            public final class RootComponentImpl: Component, RootComponent {
              public let objectA: ObjectA = .init()
              public let objectB: ObjectB = .init()
              public let objectC: ObjectC = .init()
            }
            """,
            expandedSource: """
            protocol RootComponent: Component {
              var objectA: ObjectA { get }
              var objectB: ObjectB { get }
              var objectC: ObjectC { get }
            }
            public final class RootComponentImpl: Component, RootComponent {
              public let objectA: ObjectA = .init()
              public let objectB: ObjectB = .init()
              public let objectC: ObjectC = .init()

                public var customMirror: Mirror {
                       return Mirror(self,
                                     children: [
                                      "objectA": objectA,
                                                 "objectB": objectB,
                                                 "objectC": objectC
                                    ])
                   }
            }

            extension RootComponentImpl: CustomReflectable {
            }
            """,
            macros: testMacros
    )
#else
    throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
  }
  
  func testBuildingMacro() throws {
#if canImport(HuddleMacrosMacros)
    assertMacroExpansion(
          """
          public protocol TestBuilding: ViewBuilding, ModuleBuilder {
          }
          
          @Building(TestRouter.self, TestViewComponent.self)
          public struct TestBuilder: TestBuilding {
          }
          
          """,
          expandedSource: """
          public protocol TestBuilding: ViewBuilding, ModuleBuilder {
          }
          public struct TestBuilder: TestBuilding {
          
              public static func buildRouter(component: TestViewComponent) -> TestRouter {
                 TestRouter(component: component)
               }
          }
          """,
          macros: testMacros
    )
#else
    throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
  }
  
  func testMacro() throws {
#if canImport(HuddleMacrosMacros)
    assertMacroExpansion(
            """
            protocol RootComponent: Component {
              var objectA: ObjectA { get }
              var objectB: ObjectB { get }
              var objectC: ObjectC { get }
            }
            
            @ComponentImpl
            public final class RootComponentImpl: Component, RootComponent {
              public let objectA: ObjectA
              public let objectB: ObjectB
              public let objectC: ObjectC
            }
            """,
            expandedSource: """
            protocol RootComponent: Component {
              var objectA: ObjectA { get }
              var objectB: ObjectB { get }
              var objectC: ObjectC { get }
            }
            public final class RootComponentImpl: Component, RootComponent {
              public let objectA: ObjectA
              public let objectB: ObjectB
              public let objectC: ObjectC
            
                public var customMirror: Mirror {
                       return Mirror(self,
                                     children: [
                                      "objectA": objectA,
                                                 "objectB": objectB,
                                                 "objectC": objectC
                                    ])
                   }
            
                public override init(parent: Component) {
                    self.objectA = parent.objectA
                    self.objectB = parent.objectB
                    self.objectC = parent.objectC
                    super.init(parent: parent)
                }
            }
            
            extension RootComponentImpl: CustomReflectable {
            }
            """,
            macros: testMacros
    )
#else
    throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
  }
  
  
  func testMacro_predefined_set_variables() throws {
#if canImport(HuddleMacrosMacros)
    assertMacroExpansion(
    """
    protocol RootComponent: Component {
      var objectA: ObjectA { get }
      var objectB: ObjectB { get }
      var objectC: ObjectC { get }
    }
    
    @ComponentImpl
    public final class RootComponentImpl: Component, RootComponent {
      public let objectA: ObjectA
      public let objectB: ObjectB
      public let objectC: ObjectC
    
      var objectCD: ObjectC = ObjectC()
    }
    """,
    expandedSource: """
    protocol RootComponent: Component {
      var objectA: ObjectA { get }
      var objectB: ObjectB { get }
      var objectC: ObjectC { get }
    }
    public final class RootComponentImpl: Component, RootComponent {
      public let objectA: ObjectA
      public let objectB: ObjectB
      public let objectC: ObjectC
    
      var objectCD: ObjectC = ObjectC()
    
        public var customMirror: Mirror {
               return Mirror(self,
                             children: [
                              "objectA": objectA,
                                         "objectB": objectB,
                                         "objectC": objectC,
                                         "objectCD": objectCD
                            ])
           }
    
        public override init(parent: Component) {
            self.objectA = parent.objectA
            self.objectB = parent.objectB
            self.objectC = parent.objectC
            super.init(parent: parent)
        }
    }
    
    extension RootComponentImpl: CustomReflectable {
    }
    """,
    macros: testMacros
    )
#else
    throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
  }
  
  func testMacro_predefined_block_Variables() throws {
#if canImport(HuddleMacrosMacros)
    assertMacroExpansion(
          """
          protocol RootComponent: Component {
            var objectA: ObjectA { get }
            var objectB: ObjectB { get }
            var objectC: ObjectC { get }
          }
          
          @ComponentImpl
          public final class RootComponentImpl: Component, RootComponent {
            public let objectA: ObjectA
            public let objectB: ObjectB
            public let objectC: ObjectC
          
            var objectCD: ObjectC {
              ObjectC()
            }
          }
          """,
          expandedSource: """
          protocol RootComponent: Component {
            var objectA: ObjectA { get }
            var objectB: ObjectB { get }
            var objectC: ObjectC { get }
          }
          public final class RootComponentImpl: Component, RootComponent {
            public let objectA: ObjectA
            public let objectB: ObjectB
            public let objectC: ObjectC
          
            var objectCD: ObjectC {
              ObjectC()
            }
          
              public var customMirror: Mirror {
                     return Mirror(self,
                                   children: [
                                    "objectA": objectA,
                                               "objectB": objectB,
                                               "objectC": objectC,
                                               "objectCD": { [weak self] in
                                                guard let self else {
                                                        fatalError("Mirror failed to find self")
                                                    }
                                                return objectCD
                                                   }
                                  ])
                 }
          
              public override init(parent: Component) {
                  self.objectA = parent.objectA
                  self.objectB = parent.objectB
                  self.objectC = parent.objectC
                  super.init(parent: parent)
              }
          }
          
          extension RootComponentImpl: CustomReflectable {
          }
          """,
          macros: testMacros
    )
#else
    throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
  }
}
