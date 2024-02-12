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
  subscript<T>(dynamicMember member: String) -> T? where T : Module { get }
  func module<T, R: RawRepresentable<String>>(for id: R) -> T?
  func router<T, M, R: RawRepresentable<String>>(for id: R, moduleType: M.Type) -> T?
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
  
  public subscript<T>(dynamicMember member: String) -> T? {
    var holder: ModuleHolding? = self
    while holder != nil {
      
      if let m: T = holder?.supportedModules.first(where: { $0.key == member }) as? T {
        return m
      }
      
      holder = self.holder
    }
    
    return nil
  }

  public func module<T, R: RawRepresentable<String>>(for id: R) -> T? {
    let t: T? = self[dynamicMember: id.rawValue]
    return t
  }
  
  public func router<T, M, R: RawRepresentable<String>>(for id: R, moduleType: M.Type) -> T? {
    let t: M? = self[dynamicMember: id.rawValue]
    let r = t as? (any Module)
    return r?.router as? T
  }
}
