//
//  ___FILEHEADER___
//

import Foundation
import HuddleArch
import HuddleMacros

public protocol ___VARIABLE_productName:identifier___Building: ViewBuilding, ModuleBuilder {}

@Building(___VARIABLE_productName:identifier___Router.self, ___VARIABLE_productName:identifier___ViewComponentImpl.self)
public struct ___VARIABLE_productName:identifier___Builder: ___VARIABLE_productName:identifier___Building {
  public static func build(parentComponent: Component, holder: ModuleHolding?, context: ___VARIABLE_parentModuleHolderContextClass:identifier___) -> ___VARIABLE_productName:identifier___Module {
      let component = ___VARIABLE_productName:identifier___ModuleComponentImpl(parent: parentComponent)
      let module = ___VARIABLE_productName:identifier___Module(holder: holder, context: context, component: component)

      let viewComponent = ___VARIABLE_productName:identifier___ViewComponentImpl(module: module, moduleHolder: holder)
      module.router = buildRouter(component: viewComponent)
      
      return module
  }
}

