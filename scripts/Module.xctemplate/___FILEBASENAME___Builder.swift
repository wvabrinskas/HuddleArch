//
//  ___FILEHEADER___
//

import Foundation
import HuddleArch
import HuddleMacros

public protocol ___VARIABLE_moduleName:identifier___Building: ViewBuilding, ModuleBuilder {}

@Building(___VARIABLE_moduleName:identifier___Router, ___VARIABLE_moduleName:identifier___ViewComponent)
public struct ___VARIABLE_moduleName:identifier___Builder: ___VARIABLE_moduleName:identifier___Building {
  public func build(parentComponent: Component, holder: ModuleHolding?, context: ___VARIABLE_parentModuleHolderContextClass:identifier___) -> ___VARIABLE_moduleName:identifier___Module {
      let component = ___VARIABLE_moduleName:identifier___ModuleComponentImpl(parent: parentComponent)
      let module = ___VARIABLE_moduleName:identifier___Module(holder: holder, context: context, component: component)

      let viewComponent = ___VARIABLE_moduleName:identifier___ViewComponentImpl(module: module, moduleHolder: holder)
      module.router = buildRouter(component: viewComponent)
      
      return module
  }
}

