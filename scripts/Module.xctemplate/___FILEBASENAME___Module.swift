//
//  ___FILEHEADER___
//

import Foundation
import HuddleArch
import HuddleMacros

public protocol ___VARIABLE_productName:identifier___ModuleComponent: Component {
  // add dependencies here
}

@ComponentImpl
public class ___VARIABLE_productName:identifier___ModuleComponentImpl: Component, ___VARIABLE_productName:identifier___ModuleComponent {
  // implement dependencies here
}

public protocol ___VARIABLE_productName:identifier___Supporting {
  var viewModel: ___VARIABLE_productName:identifier___ViewModel { get }
}

public final class ___VARIABLE_productName:identifier___Module: ModuleObject<___VARIABLE_parentModuleHolderContextClass:identifier___, ___VARIABLE_productName:identifier___ModuleComponentImpl,  ___VARIABLE_productName:identifier___Router>, ___VARIABLE_productName:identifier___Supporting {
  public var viewModel: ___VARIABLE_productName:identifier___ViewModel = ___VARIABLE_productName:identifier___ViewModel()

  @MainActor
  public required init(holder: ModuleHolding?, context: Context, component: ___VARIABLE_productName:identifier___ModuleComponentImpl) {
    super.init(holder: holder, context: context, component: component)
  }
}