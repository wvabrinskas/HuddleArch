//
//  Module.swift
//  Huddle
//
//  Created by William Vabrinskas on 1/31/23.
//

import Foundation

public protocol ComponentProviding: AnyObject, ModuleComponent {
  var parent: Component? { get }
  subscript<T>(dynamicMember member: String) -> T { get }
}

@dynamicMemberLookup
public class Component: ComponentProviding {
  public let parent: Component?

  private var sharedDependencies: [String: Any] = [:]
  private var cachedProperties: [String: Any] = [:]
  
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
        if c.label == member, let value = c.value as? T {
          cachedProperties[member] = value
          return value
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

public protocol ModuleBuilder {
  associatedtype M: Module
  func build(parentComponent: Component, holder: ModuleHolding?, context: M.Context) -> M
}

public protocol Module {
  associatedtype Context: ModuleHoldingContext
  associatedtype Component
  associatedtype Router: Routing
  
  var key: SupportedModules { get }
  var holder: ModuleHolding? { get }
  var router: Router? { get }
  
  init(holder: ModuleHolding?, context: Context, component: Component)
}

open class ModuleObject<Context: ModuleHoldingContext, Component, Router: Routing>: NSObject, Module {
  open var key: SupportedModules { .none }
  
  open weak var holder: ModuleHolding?
  
  open var router: Router?
  
  public required init(holder: ModuleHolding?, context: Context, component: Component) {
    self.holder = holder
  }
}
