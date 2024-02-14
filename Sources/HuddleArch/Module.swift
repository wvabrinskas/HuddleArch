//
//  Module.swift
//  Huddle
//
//  Created by William Vabrinskas on 1/31/23.
//

import Foundation

public protocol Module {
  associatedtype Context: ModuleHoldingContext
  associatedtype Component
  associatedtype Router: Routing
  
  var holder: ModuleHolding? { get }
  var router: Router? { get }
  
  init(holder: ModuleHolding?, context: Context, component: Component)
  func onActive()
}

open class ModuleObject<Context: ModuleHoldingContext, Component, Router: Routing>: NSObject, Module {
  open weak var holder: ModuleHolding?
  
  open var router: Router?
  
  public required init(holder: ModuleHolding?, context: Context, component: Component) {
    self.holder = holder
  }
  
  public func onActive() {
    // no op. Override to perform action when Holder is ready
  }
}
