//
//  ComponentTests.swift
//  HuddleTests
//
//  Created by William Vabrinskas on 3/27/23.
//

import Foundation
import XCTest
@testable import HuddleArch

public class ComponentTests: XCTestCase {
  
  private class FruitComponent: Component {
    var apple: String
    var banana: Int
    
    init(parent: Component?,
         apple: String,
         banana: Int) {
      self.apple = apple
      self.banana = banana
      super.init(parent: parent)
    }
  }
  
  private class ObjectComponent: Component {
    var baseball: String
    var skateboard: Int
    
    init(parent: Component?,
         baseball: String,
         skateboard: Int) {
      self.baseball = baseball
      self.skateboard = skateboard
      super.init(parent: parent)
    }
  }
  
  private class ObjectAndFruitComponent: Component {
    var baseball: String
    var banana: Int

    init(parent: Component?,
         baseball: String,
         banana: Int) {
      self.baseball = baseball
      self.banana = banana
      super.init(parent: parent)
    }
  }
  
  private class RootComponent: Component {
    var apple: String
    var banana: Int
    
    init(parent: Component?,
         apple: String = "apple",
         banana: Int = 123456) {
      self.apple = apple
      self.banana = banana
      
      super.init(parent: parent)
    }
  }
  
  private class NewComponent: Component {
    var baseball: String
    var skateboard: Int
    
    init(parent: Component?,
         baseball: String = "baseball",
         skateboard: Int = 7890) {
      self.baseball = baseball
      self.skateboard = skateboard
      
      super.init(parent: parent)
    }
  }
  
  func test_componentDynamicLookup() {
    let mainComponent: Component = NewComponent(parent: nil)

    let objectComponent = ObjectComponent(parent: mainComponent,
                                          baseball: mainComponent.baseball,
                                          skateboard: mainComponent.skateboard)
    
    XCTAssertEqual(objectComponent.baseball, "baseball")
    XCTAssertEqual(objectComponent.skateboard, 7890)
  }
  
  func test_componentTreeDynamicLookup() {
    let rootComponent: Component = RootComponent(parent: nil)
    
    let mainComponent: Component = NewComponent(parent: rootComponent)
    
    let objectComponent = ObjectAndFruitComponent(parent: mainComponent,
                                                  baseball: mainComponent.baseball,
                                                  banana: mainComponent.banana)
    
    XCTAssertEqual(objectComponent.baseball, "baseball")
    XCTAssertEqual(objectComponent.banana, 123456)
  }
}
