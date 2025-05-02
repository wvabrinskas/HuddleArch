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
  public var moduleHolder: ModuleHolding?
}

@MainActor
public protocol ___VARIABLE_productName:identifier___Routing: Router {}

@MainActor
public class ___VARIABLE_productName:identifier___Router: Router, ___VARIABLE_productName:identifier___Routing {
  private let moduleHolder: ___VARIABLE_parentModuleHolderClassName:identifier___?
  private let component: ___VARIABLE_productName:identifier___ViewComponent
  
  public init(component: ___VARIABLE_productName:identifier___ViewComponent) {
    self.component = component
    self.moduleHolder = component.moduleHolder as? ___VARIABLE_parentModuleHolderClassName:identifier___
    
    super.init()
  }
  
  public override func rootView() -> any View {
    ___VARIABLE_productName:identifier___View(router: self, 
                       module: component.module, 
                       moduleHolder: component.moduleHolder, 
                       viewModel: component.module.viewModel)
  }
}