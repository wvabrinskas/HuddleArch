//
//  ___FILEHEADER___
//

import Foundation
import SwiftUI
import Logger
import HuddleArch

public protocol ___VARIABLE_moduleName:identifier___ViewComponent: ViewComponent {
  var module: ___VARIABLE_moduleName:identifier___Supporting { get }
}

public struct ___VARIABLE_moduleName:identifier___ViewComponentImpl: ___VARIABLE_moduleName:identifier___ViewComponent {
  public var module: ___VARIABLE_moduleName:identifier___Supporting
  public var moduleHolder: ModuleHolding?
}

public protocol ___VARIABLE_moduleName:identifier___Routing: Routing {}

@MainActor
public class ___VARIABLE_moduleName:identifier___Router: ___VARIABLE_moduleName:identifier___Routing, @preconcurrency Logger {
  public var logLevel: LogLevel = .high
  private let moduleHolder: ___VARIABLE_parentModuleHolderClassName:identifier___?
  private let component: ___VARIABLE_moduleName:identifier___ViewComponent
  
  public init(component: ___VARIABLE_moduleName:identifier___ViewComponent) {
    self.component = component
    self.moduleHolder = component.moduleHolder as? ___VARIABLE_parentModuleHolderClassName:identifier___
    if moduleHolder == nil {
      log(type: .message, message: "No valid ModuleHolder to be found in \(#file)")
    }
  }
  
  public func rootView() -> any View {
    ___VARIABLE_moduleName:identifier___View(router: self, module: component.module, moduleHolder: component.moduleHolder, viewModel: component.module.viewModel)
  }
}
