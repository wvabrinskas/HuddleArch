//
//  ___FILEHEADER___
//

import Foundation
import SwiftUI
import HuddleArch

public protocol ___VARIABLE_moduleName:identifier___ViewComponent: ViewComponent {
  var module: ___VARIABLE_moduleName:identifier___Supporting { get }
}

public struct ___VARIABLE_moduleName:identifier___ViewComponentImpl: ___VARIABLE_moduleName:identifier___ViewComponent {
  public var module: ___VARIABLE_moduleName:identifier___Supporting
  public var moduleHolder: (any ModuleHolding)?
}

@MainActor
public protocol ___VARIABLE_moduleName:identifier___Routing: Router {
}

@MainActor
public final class ___VARIABLE_moduleName:identifier___Router: Router, ___VARIABLE_moduleName:identifier___Routing {
  private let module: ___VARIABLE_moduleName:identifier___Supporting
  private var moduleHolder: ___VARIABLE_moduleHolderClassName:identifier___ModuleHolder?
  
  public init(component: ___VARIABLE_moduleName:identifier___ViewComponent) {
    self.moduleHolder = component.moduleHolder as? ___VARIABLE_moduleHolderClassName:identifier___ModuleHolder
    self.module = component.module
    
    super.init()
  }
  
  public override func rootView() -> any View {
    return ___VARIABLE_moduleName:identifier___View(module: module,
                    router: self,
                    viewModel: module.viewModel)
  }
}
