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

public enum SupportedModules: String {
  case root, settings, peerConnection, feed
}

protocol TestRootRouting: Routing {}
class TestRootRouter: TestRootRouting {
  func rootView() -> any View {
    Text("")
  }
}

class TestRootComponent: Component {}
class TestRootContext: ModuleHolderContext {
}

class TestRootModuleHolder: ModuleHolder, Module {
  var key: String = SupportedModules.root.rawValue
  
  var router: TestRootRouter? = TestRootRouter()

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
  
  override var key: String { SupportedModules.feed.rawValue }
    
  public required init(holder: ModuleHolding?, context: TestRootContext, component: TestComponent) {
    super.init(holder: holder, context: context, component: component)
    self.router = TestRouter()
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

class TestSecondRootModule: ModuleHolder, Module {
  var key: String = SupportedModules.settings.rawValue
  
  var router: TestSecondRootRouter? = TestSecondRootRouter()
  
  public required init(holder: ModuleHolding?,
                       context: TestSecondRootContext,
                       component: TestSecondRootComponent) {
    super.init(holder: holder)
        
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

class TestSecondModule:  ModuleObject<TestSecondRootContext, TestSecondComponent, TestSecondRouter> {
  typealias Context = TestSecondRootContext
  typealias Component = TestSecondComponent
  typealias Router = TestSecondRouter
  
  override var key: String { SupportedModules.peerConnection.rawValue }

  public required init(holder: ModuleHolding?,
                       context: TestSecondRootContext,
                       component: TestSecondComponent) {
    super.init(holder: holder, context: context, component: component)
    self.router = TestSecondRouter()
  }
}


public class ModuleHolderTests: XCTestCase {
  
  func test_getFirstLevelModule_fromSecondLevel() {
    let root = TestRootModuleHolder(holder: nil,
                                    context: TestRootContext(),
                                    component: TestRootComponent(parent: nil))
    
    let secondLevelRoot: TestSecondRootModule? = root.module(for: SupportedModules.settings)
    
    XCTAssertNotNil(secondLevelRoot)
    
    let feedFromFirst: TestModule? = secondLevelRoot?.module(for: SupportedModules.feed)
    
    XCTAssertNotNil(feedFromFirst)
  }
  
}
