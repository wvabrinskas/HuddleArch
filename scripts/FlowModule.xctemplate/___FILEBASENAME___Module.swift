//
//  ___FILEHEADER___
//

import Foundation
import HuddleArch
import HuddleMacros

public struct ___VARIABLE_productName:identifier___FlowContext {
  var isPreviews: Bool {
    ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil
  }
}

public protocol ___VARIABLE_productName:identifier___ModuleComponent: Component {
  // add dependencies here
}

@ComponentImpl
public class ___VARIABLE_productName:identifier___ModuleComponentImpl: Component, ___VARIABLE_productName:identifier___ModuleComponent {
  // implement dependencies here
}

public protocol ___VARIABLE_productName:identifier___Supporting: Flow<___VARIABLE_productName:identifier___FlowContext, ___VARIABLE_productName:identifier___ModuleComponentImpl, EmptyResult> {
  var viewModel: ___VARIABLE_productName:identifier___ViewModel { get }
}

public final class ___VARIABLE_productName:identifier___Module: Flow<___VARIABLE_productName:identifier___FlowContext, ___VARIABLE_productName:identifier___ModuleComponentImpl, EmptyResult>,
                                    ___VARIABLE_productName:identifier___Supporting,
                                    Module {
  
  public weak var holder: ModuleHolding?
  public weak var router: ___VARIABLE_productName:identifier___Router?
  public var viewModel: ___VARIABLE_productName:identifier___ViewModel = ___VARIABLE_productName:identifier___ViewModel()
  
  deinit {
    // remove steps as this can cause a memory leak
    steps = []
  }
  
  public func onActive() {
    // no op
  }
  
  public func onAppear() {
    // no op
  }
  
  @MainActor
  public override func runIsolated() async {
    await super.runIsolated()
  }
  
  public init(holder: ModuleHolding?, context: ___VARIABLE_parentModuleHolderContextClass:identifier___, component: ___VARIABLE_productName:identifier___ModuleComponentImpl) {
    self.holder = holder
    
    let context = ___VARIABLE_productName:identifier___FlowContext()
    
    super.init(context: context, component: component)
    
    self.steps = [

    ]
  }
}