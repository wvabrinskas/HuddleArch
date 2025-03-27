//
//  Module.swift
//  Huddle
//
//  Created by William Vabrinskas on 1/31/23.
//

import Foundation

public protocol Module {
  associatedtype Context: ModuleHoldingContext
  associatedtype ModuleComponent: Component
  associatedtype Router: Routing
  
  var holder: ModuleHolding? { get }
  var router: Router? { get }
  
  init(holder: ModuleHolding?, context: Context, component: ModuleComponent)
  func onActive()
}

open class ModuleObject<Context: ModuleHoldingContext, ModuleComponent: Component, Router: Routing>: NSObject, Module {
  open weak var holder: ModuleHolding?
  
  @MainActor open var router: Router?
  
  public required init(holder: ModuleHolding?, context: Context, component: ModuleComponent) {
    self.holder = holder
  }
  
  open func onActive() {
    // no op. Override to perform action when Holder is ready
  }
  
  @MainActor
  public func setRouter(_ router: Router?) {
    self.router = router
  }
}
