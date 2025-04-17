//
//  ___FILEHEADER___
//
import Foundation
import SwiftUI
import HuddleArch
import HuddleMacros

public protocol ___VARIABLE_productName:identifier___Supporting {
  var viewModel: ___VARIABLE_productName:identifier___ViewModel { get }
}

public protocol ___VARIABLE_productName:identifier___Component: Component {
}

@RootComponentImpl
public class ___VARIABLE_productName:identifier___ModuleComponentImpl: Component, ___VARIABLE_productName:identifier___Component {
  public init() { super.init(parent: nil) }
}

public class ___VARIABLE_productName:identifier___ModuleHolderContext: ModuleHolderContext {}

public class ___VARIABLE_productName:identifier___ModuleHolder: ModuleHolder, ___VARIABLE_productName:identifier___Supporting, Module, @unchecked Sendable {
  public typealias ModuleComponent = ___VARIABLE_productName:identifier___ModuleComponentImpl
  public typealias Context = ___VARIABLE_productName:identifier___ModuleHolderContext
  public typealias Router = ___VARIABLE_productName:identifier___Router
    
  // we don't need weak here because the Router references the module through the Component and 
  // not the router directly, so there's no reference cycle.
  public var router: Router? 
  public var viewModel: ___VARIABLE_productName:identifier___ViewModel = ___VARIABLE_productName:identifier___ViewModel()
  
  private let component: ___VARIABLE_productName:identifier___Component
  private let context: ___VARIABLE_productName:identifier___ModuleHolderContext

  @MainActor
  public required init(holder: ModuleHolding? = nil,
                       context: ___VARIABLE_productName:identifier___ModuleHolderContext,
                       component: ___VARIABLE_productName:identifier___ModuleComponentImpl) {
    self.context = context
    self.component = component
    
    super.init(holder: holder)

    supportedModules = [
      // add supported modules here
    ]
  }
  
  public func onActive() {
    // no op
  }
  
}
