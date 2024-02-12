//
//  ___FILEHEADER___
//

import Foundation
import HuddleArch

public protocol ___VARIABLE_moduleName:identifier___Building: ViewBuilding, ModuleBuilder {}

public struct ___VARIABLE_moduleName:identifier___Builder: ___VARIABLE_moduleName:identifier___Building {
  public func buildRouter<T, R>(component: T) -> R? where T : ViewComponent, R : Routing {
    guard let c = component as? ___VARIABLE_moduleName:identifier___ViewComponent else { return nil }
    return ___VARIABLE_moduleName:identifier___Router(component: c) as? R
  }
  
  public func build(parentComponent: Component, holder: ModuleHolding?, context: ___VARIABLE_parentModuleHolderContextClass:identifier___) -> ___VARIABLE_moduleName:identifier___Module {
      let component = ___VARIABLE_moduleName:identifier___ModuleComponentImpl(parent: parentComponent)
      let module = ___VARIABLE_moduleName:identifier___Module(holder: holder, context: context, component: component)

      let viewComponent = ___VARIABLE_moduleName:identifier___ViewComponentImpl(module: module, moduleHolder: holder)
      module.router = buildRouter(component: viewComponent)
      
      return module
  }
}

