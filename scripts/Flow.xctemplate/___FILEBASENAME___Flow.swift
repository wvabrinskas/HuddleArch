//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//

import Foundation
import HuddleArch
import HuddleMacros

public protocol ___VARIABLE_productName___FlowSupporting: Flow<___VARIABLE_productName___FlowContext, ___VARIABLE_productName___FlowComponentImpl, EmptyResult> {

}

public struct ___VARIABLE_productName___FlowContext {

}

public protocol ___VARIABLE_productName___FlowComponent: Component {

}

@ComponentImpl
public final class ___VARIABLE_productName___FlowComponentImpl: Component, ___VARIABLE_productName___FlowComponent {
}

public final class ___VARIABLE_productName___Flow: Flow<___VARIABLE_productName___FlowContext, ___VARIABLE_productName___FlowComponentImpl, EmptyResult>,
                                   ___VARIABLE_productName___FlowSupporting {
  override public init(context: ___VARIABLE_productName___FlowContext,
                     component: ___VARIABLE_productName___FlowComponentImpl,
                     result: (@Sendable () -> EmptyResult?)? = nil) {
    super.init(context: context, component: component, result: result)
    
    self.steps = [
    ]
  }
}