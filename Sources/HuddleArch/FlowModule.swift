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
  func run() async
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
  
  open func run() async {
    for step in steps {
      if step.isApplicable(context: context) {
        await step.run()
      }
    }
  }
  
}
