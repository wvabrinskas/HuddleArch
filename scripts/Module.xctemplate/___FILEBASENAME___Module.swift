//
//  ___FILEHEADER___
//

import Foundation
import HuddleArch

public protocol ___VARIABLE_productName:identifier___ModuleComponent: Component {
  // add dependencies here
}

public class ___VARIABLE_productName:identifier___ModuleComponentImpl: Component, ___VARIABLE_productName:identifier___ModuleComponent {
  // implement dependencies here

  public override init(parent: Component) {
    super.init(parent: parent)
  }
}

public protocol ___VARIABLE_productName:identifier___Supporting {
  var viewModel: ___VARIABLE_productName:identifier___ViewModel { get }
}

public final class ___VARIABLE_productName:identifier___Module: ModuleObject<___VARIABLE_parentModuleHolderContextClass:identifier___, ___VARIABLE_productName:identifier___ModuleComponent,  ___VARIABLE_productName:identifier___Router>, ___VARIABLE_productName:identifier___Supporting {
  public var viewModel: ___VARIABLE_productName:identifier___ViewModel = ___VARIABLE_productName:identifier___ViewModel()

  public required init(holder: ModuleHolding?, context: Context, component: Component) {
    super.init(holder: holder, context: context, component: component)
  }
}