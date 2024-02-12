//
//  Building.swift
//  Huddle
//
//  Created by William Vabrinskas on 2/3/23.
//

import Foundation

public protocol ModuleComponent: Component {
  var parent: Component? { get }
}

public protocol ViewComponent {
  var moduleHolder: ModuleHolding? { get }
}

public protocol ViewBuilding {
  func buildRouter<C: ViewComponent, R: Routing>(component: C) -> R?
}

public protocol ModuleBuilder {
  associatedtype M: Module
  func build(parentComponent: Component, holder: ModuleHolding?, context: M.Context) -> M
}
