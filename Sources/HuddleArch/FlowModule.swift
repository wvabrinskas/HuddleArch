//
//  FlowModule.swift
//  Huddle
//
//  Created by William Vabrinskas on 5/26/23.
//

import Foundation

public struct EmptyResult: FlowResult {
  public func updating(_ with: EmptyResult) -> EmptyResult {
    .init()
  }
}

public protocol FlowResult: Sendable {
  func updating(_ with: Self) -> Self
}

fileprivate protocol FlowModuleSupporting {
  associatedtype FlowType: Flowing
  associatedtype ResultObject: FlowResult
  var result: ResultObject? { get set }
  var steps: [FlowType] { get }
  var onComplete: (() -> ())? { get set }
  func run() async
  func run() async -> ResultObject?
}

open class FlowModule<FC, ResultObject: FlowResult>: FlowModuleSupporting {
  public typealias FlowType = Flow<FC, ResultObject>
  public var result: ResultObject?
  public var steps: [FlowType] = []
  public var onComplete: (() -> ())? = nil
  
  private var stepIndex: Int = 0
  private var context: FC
  
  public init(context: FC, result: (@Sendable () -> ResultObject?)? = nil) {
    self.context = context
    self.result = result?()
  }
  
  open func run() async -> ResultObject? {
    var resultToReturn: ResultObject?
    
    for step in steps {
      if step.isApplicable(context: context) {
        resultToReturn = await step.run(flowResult: resultToReturn)
        result = resultToReturn
      }
    }
    
    return resultToReturn
  }
  
  open func run() async {
    for step in steps {
      if step.isApplicable(context: context) {
        await step.run()
      }
    }
  }
  
}
