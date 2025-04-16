//
//  ___FILEHEADER___
//

import Foundation
import SwiftUI
import HuddleArch

public protocol ___VARIABLE_productName:identifier___ViewComponent: ViewComponent {
  var module: ___VARIABLE_productName:identifier___Supporting { get }
}

public struct ___VARIABLE_productName:identifier___ViewComponentImpl: ___VARIABLE_productName:identifier___ViewComponent {
  public var module: ___VARIABLE_productName:identifier___Supporting
  public var moduleHolder: (any ModuleHolding)?
}

@MainActor
public protocol ___VARIABLE_productName:identifier___Routing: Router {
}

@MainActor
public final class ___VARIABLE_productName:identifier___Router: Router, ___VARIABLE_productName:identifier___Routing {
  private let module: ___VARIABLE_productName:identifier___Supporting
  private var moduleHolder: ___VARIABLE_productName:identifier___ModuleHolder?
  
  public init(component: ___VARIABLE_productName:identifier___ViewComponent) {
    self.moduleHolder = component.moduleHolder as? ___VARIABLE_productName:identifier___ModuleHolder
    self.module = component.module
    
    super.init()
  }
  
  public override func rootView() -> any View {
    return ___VARIABLE_productName:identifier___View(module: module,
                    router: self,
                    viewModel: module.viewModel)
  }
}
