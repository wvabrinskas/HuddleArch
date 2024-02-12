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
  subscript<M: Module>(dynamicMember member: M.Type) -> M? { get }
  func module<M: Module>(for id: M.Type) -> M?
  func router<M: Module>(for id: M.Type) -> M.Router?
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

open class ModuleHolder: ModuleHolding {
  public var holder: ModuleHolding? = nil
  public var supportedModules: [any Module] = []
  
  public init(holder: ModuleHolding? = nil) {
    self.holder = holder
  }
  
  public subscript<T, M: Module>(dynamicMember member: M.Type) -> T? where T : Module {
    var holder: ModuleHolding? = self
    while holder != nil {
      
      if let m: T = holder?.supportedModules.first(where: { $0 is M }) as? T {
        return m
      }
      
      holder = self.holder
    }
    
    return nil
  }

  public func module<M: Module>(for id: M.Type) -> M? {
    let t: M? = self[dynamicMember: id]
    return t
  }
  
  public func router<M: Module>(for id: M.Type) -> M.Router? {
    let t: M? = self[dynamicMember: id]
    return t?.router as? M.Router
  }
}
