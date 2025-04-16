//
//  ___FILEHEADER___
//

import Foundation
import HuddleArch
import HuddleMacros

public protocol ___VARIABLE_moduleName:identifier___Building: ViewBuilding, ModuleBuilder {}

@Building(___VARIABLE_moduleName:identifier___Router, ___VARIABLE_moduleName:identifier___ViewComponentImpl)
public struct ___VARIABLE_moduleName:identifier___Builder: ___VARIABLE_moduleName:identifier___Building {
  public static func build(parentComponent: Component, holder: ModuleHolding?, context: ___VARIABLE_moduleHolderContextClass:identifier___) -> ___VARIABLE_moduleName:identifier___ModuleHolder {
      let component = ___VARIABLE_moduleName:identifier___ModuleComponentImpl()
      let module = ___VARIABLE_moduleName:identifier___ModuleHolder(holder: nil, context: context, component: component)

      let viewComponent = ___VARIABLE_moduleName:identifier___ViewComponentImpl(module: module, moduleHolder: holder)
      module.router = buildRouter(component: viewComponent)
      
      return module
  }
}