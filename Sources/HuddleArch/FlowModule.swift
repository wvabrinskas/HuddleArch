//
//  FlowModule.swift
//  Huddle
//
//  Created by William Vabrinskas on 5/26/23.
//

import Foundation

fileprivate protocol FlowModuleSupporting {
  associatedtype FlowType: Flowing
  var steps: [FlowType] { get }
  var onComplete: (() -> ())? { get set }
  func onNext()
  func run()
}

open class FlowModule<FC>: FlowModuleSupporting {
  public typealias FlowType = Flow<FC>
  public var steps: [FlowType] = []
  public var onComplete: (() -> ())? = nil
  
  private var stepIndex: Int = 0
  private var context: FC
  
  public init(context: FC) {
    self.context = context
  }
  
  open func run() {
    guard stepIndex < steps.count else {
      onComplete?()
      return
    }
    if steps[stepIndex].isApplicable(context: context) {
      steps[stepIndex].run()
    } else {
      onNext()
    }
  }
  
  open func onNext() {
    stepIndex += 1
    run()
  }
}
