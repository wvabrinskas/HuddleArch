//
//  ___FILEHEADER___
//

import Foundation
import HuddleArch
import HuddleMacros

public protocol ___VARIABLE_productName:identifier___Building: ViewBuilding, ModuleBuilder {}

@Building(___VARIABLE_productName:identifier___Router.self, ___VARIABLE_productName:identifier___ViewComponentImpl.self)
public struct ___VARIABLE_productName:identifier___Builder: ___VARIABLE_productName:identifier___Building {
  public static func build(parentComponent: Component, holder: ModuleHolding?, context: ___VARIABLE_productName:identifier___ModuleHolderContext) -> ___VARIABLE_productName:identifier___ModuleHolder {
      let component = ___VARIABLE_productName:identifier___ModuleComponentImpl()
      let module = ___VARIABLE_productName:identifier___ModuleHolder(holder: nil, context: context, component: component)

      let viewComponent = ___VARIABLE_productName:identifier___ViewComponentImpl(module: module, moduleHolder: holder)
      module.router = buildRouter(component: viewComponent)
      
      return module
  }
}