//
//  File.swift
//  
//
//  Created by William Vabrinskas on 2/12/24.
//

import Foundation

public final class EmptyComponent: Component {
  public init() {
    super.init(parent: nil)
  }
}

public final class EmptyFlowComponent: Component, FlowStepComponent {
  public init() {
    super.init(parent: nil)
  }
}

public protocol ComponentProviding: AnyObject {
  var parent: Component? { get }
  subscript<T>(dynamicMember member: String) -> T { get }
}

@dynamicMemberLookup
open class Component: ComponentProviding {
  public let parent: Component?

  private var sharedDependencies: [String: Any] = [:]
  private var cachedProperties: [String: Any] = [:]
  
  public init(parent: Component) {
    self.parent = parent
  }
  
  public init(parent: Component?) {
    self.parent = parent
  }

  public subscript<T>(dynamicMember member: String) -> T {
    if let cached = cachedProperties[member], let val = cached as? T {
      return val
    }
    
    var component: Component? = self
    
    var tree: String = ""
    
    while let comp = component {
      tree += "\(tree.isEmpty ? "" : " -> ")\(String(describing: comp))"
      
      let mirror = Mirror(reflecting: comp)
      
      for c in mirror.children {
        if c.label == member {
          if let value = c.value as? T {
            cachedProperties[member] = value
            return value
          } else if let valueBlock = c.value as? () -> T {
            let value = valueBlock()
            cachedProperties[member] = value
            return value
          }
        }
      }
      
      component = component?.parent
    }

    fatalError("Cannot find \(member): \(String(describing: T.self)) in component graph: \(tree) ")
  }
  
  public func shared<T>(_ block: () -> T) -> T {
    if let oldDep = sharedDependencies[String(describing: T.self)] {
      return oldDep as? T ?? block()
    }
    
    let dep = block()
    sharedDependencies[String(describing: T.self)] = dep
    return dep
  }
}
