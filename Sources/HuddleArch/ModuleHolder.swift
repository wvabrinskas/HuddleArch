//
//  ModuleHolder.swift
//  Huddle
//
//  Created by William Vabrinskas on 2/3/23.
//

import Foundation

public protocol ModuleHolding: AnyObject {
  var holder: ModuleHolding? { get }
  var supportedModules: [any Module] { get set }
  func module<M>() -> M?
  func router<R, M>(for type: M.Type) -> R?
}

public protocol ModuleHoldingContext {
  var parent: ModuleHoldingContext? { get }
  func parentAs<T: ModuleHoldingContext>() -> T?
}

open class ModuleHolderContext: ModuleHoldingContext {
  public var parent: ModuleHoldingContext?
  
  public init(parent: ModuleHoldingContext? = nil) {
    self.parent = parent
  }
  
  public func parentAs<T>() -> T? where T : ModuleHoldingContext {
    var p = parent
    
    while p != nil {
      if let conformed = p as? T {
        return conformed
      }
      
      p = p?.parent
    }
    
    return nil
  }
}

open class ModuleHolderModule<Context: ModuleHoldingContext, C: Component, Router: Routing>: ModuleHolder, Module {
  public typealias Context = Context
  
  public typealias ModuleComponent = C
  
  public typealias Router = Router
  
  public var router: Router?
  
  public required init(holder: (any ModuleHolding)?, context: Context, component: C) {
    super.init(holder: holder)
  }
  
  open func onActive() {
    // no op
  }
}

open class ModuleHolder: ModuleHolding {
  public var holder: ModuleHolding? = nil
  public var supportedModules: [any Module] = [] {
    didSet {
      if supportedModules.isEmpty == false {
        supportedModules.forEach { $0.onActive() }
      }
    }
  }
  
  public init(holder: ModuleHolding? = nil) {
    self.holder = holder
  }

  public func module<M>() -> M? {
    let t: M? = self.getModule()
    return t
  }
  
  public func router<R, M>(for type: M.Type) -> R? {
    let t: M? = self.getModule()
    let r = t as? (any Module)
    return r?.router as? R
  }
  
  private func getModule<M>() -> M? {
    var holder: ModuleHolding? = self
    while holder != nil {
      
      if let m: M = holder?.supportedModules.first(where: { $0 is M }) as? M {
        return m
      }
      
      holder = holder?.holder
    }
    
    return nil
  }
}
