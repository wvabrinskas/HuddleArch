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
    "ComponentImplFree": ComponentImplFreeMacro.self
]
#endif

final class HuddleMacrosTests: XCTestCase {
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

                public override init(parent: Component) {
                    self.objectA = parent.objectA
                    self.objectB = parent.objectB
                    self.objectC = parent.objectC
                    super.init(parent: parent)
                }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
