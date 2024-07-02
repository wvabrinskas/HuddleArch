//
//  ModuleHolderTest.swift
//  HuddleTests
//
//  Created by William Vabrinskas on 4/1/23.
//

import Foundation
import XCTest
import SwiftUI
@testable import HuddleArch

@MainActor
protocol TestRootRouting: Routing {}

@MainActor
class TestRootRouter: TestRootRouting {
  func rootView() -> any View {
    Text("")
  }
}

class TestRootComponent: Component {}
class TestRootContext: ModuleHolderContext {
}

class TestRootModuleHolder: ModuleHolder, Module {
  var router: TestRootRouter?

  public required init(holder: ModuleHolding?,
                       context: TestRootContext,
                       component: TestRootComponent) {
    super.init(holder: holder)
    
    supportedModules = [TestModule(holder: self,
                                   context: context,
                                   component: TestComponent(parent: component)),
                        TestSecondRootModule(holder: self,
                                             context: TestSecondRootContext(parent: context),
                                             component: TestSecondRootComponent(parent: component))]
  }
  
  func onActive() {
    // no op
  }
}

protocol TestRouting: Routing {}
class TestRouter: TestRouting {
  func rootView() -> any View {
    Text("")
  }
}

class TestComponent: Component {}

class TestModule: ModuleObject<TestRootContext, TestComponent, TestRouter> {
  typealias Context = TestRootContext
  typealias Component = TestComponent
  typealias Router = TestRouter
      
  public required init(holder: ModuleHolding?, context: TestRootContext, component: TestComponent) {
    super.init(holder: holder, context: context, component: component)
  }
}


protocol TestSecondRootRouting: Routing {}
class TestSecondRootRouter: TestSecondRootRouting {
  func rootView() -> any View {
    Text("")
  }
}

class TestSecondRootComponent: Component {}
class TestSecondRootContext: ModuleHolderContext {}

class TestSecondRootModule: ModuleHolderModule<TestSecondRootContext, TestSecondRootComponent, TestSecondRootRouter> {
  
  public required init(holder: ModuleHolding?,
                       context: TestSecondRootContext,
                       component: TestSecondRootComponent) {
    super.init(holder: holder, context: context, component: component)
        
    supportedModules = [TestSecondModule(holder: holder,
                                         context: context,
                                         component: TestSecondComponent(parent: component))]
  }
}


protocol TestSecondRouting: Routing {}
class TestSecondRouter: TestSecondRouting {
  func rootView() -> any View {
    Text("")
  }
}

class TestSecondComponent: Component {}

class TestSecondModule: ModuleObject<TestSecondRootContext, TestSecondComponent, TestSecondRouter> {
  typealias Context = TestSecondRootContext
  typealias Component = TestSecondComponent
  typealias Router = TestSecondRouter
  
  public required init(holder: ModuleHolding?,
                       context: TestSecondRootContext,
                       component: TestSecondComponent) {
    super.init(holder: holder, context: context, component: component)
  }
}


public class ModuleHolderTests: XCTestCase {
  
  @MainActor
  func test_getFirstLevelModule_fromSecondLevel() {
    let root = TestRootModuleHolder(holder: nil,
                                    context: TestRootContext(),
                                    component: TestRootComponent(parent: nil))
    
    let secondLevelRoot: TestSecondRootModule? = root.module()
    
    XCTAssertNotNil(secondLevelRoot)
    
    let feedFromFirst: TestModule? = secondLevelRoot?.module()
    
    XCTAssertNotNil(feedFromFirst)
  }
  
}
