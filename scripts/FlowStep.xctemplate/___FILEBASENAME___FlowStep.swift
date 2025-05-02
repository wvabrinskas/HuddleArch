//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//

import HuddleArch
import HuddleMacros
import UIKit

public protocol ___VARIABLE_productName___StepComponent: FlowStepComponent {
}

@ComponentImpl
public final class ___VARIABLE_productName___StepComponentImpl: Component, ___VARIABLE_productName___StepComponent {
}

public class ___VARIABLE_productName___Step: FlowStep<___VARIABLE_flowName___FlowContext, ___VARIABLE_flowName___FlowComponentImpl, EmptyResult> {
  
  public override init<T>(flow: Flow<___VARIABLE_flowName___FlowContext, ___VARIABLE_flowName___FlowComponentImpl, EmptyResult>, context: ___VARIABLE_flowName___FlowContext, component: T) where T : FlowStepComponent {
    super.init(flow: flow, context: context, component: component)
  }
  
  public override func run() async {
    await super.run()
    onNext()
  }
  
  public override func run(flowResult: EmptyResult? = nil) async -> EmptyResult? {
    return await super.run(flowResult: flowResult)
  }
}