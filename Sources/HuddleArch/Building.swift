//
//  Building.swift
//  Huddle
//
//  Created by William Vabrinskas on 2/3/23.
//

import Foundation

nonisolated public protocol ViewComponent {
  var moduleHolder: ModuleHolding? { get }
}

public protocol ViewBuilding {
  associatedtype BuilderComponent: ViewComponent
  associatedtype BuilderRouter: Routing
  @MainActor static func buildRouter(component: BuilderComponent) -> BuilderRouter
}

nonisolated public protocol ModuleBuilder {
  associatedtype M: Module
  @MainActor
  static func build(parentComponent: Component, holder: ModuleHolding?, context: M.Context) -> M
}
