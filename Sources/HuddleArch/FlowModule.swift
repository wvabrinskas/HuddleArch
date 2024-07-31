//
//  FlowModule.swift
//  Huddle
//
//  Created by William Vabrinskas on 5/26/23.
//

import Foundation

public struct EmptyResult: FlowResult {
  public init() {}
  
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
  @MainActor func runIsolated() async
  func run() async
  func runResult() async -> ResultObject?
  @MainActor func runResultIsolated() async -> ResultObject?
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
  
  open func runResult() async -> ResultObject? {
    var resultToReturn: ResultObject?
    
    for step in steps {
      if step.isApplicable(context: context) {
        resultToReturn = await step.run(flowResult: resultToReturn)
        result = resultToReturn
      }
    }
    
    return resultToReturn
  }
  
  @MainActor
  open func runResultIsolated() async -> ResultObject? {
    await runResult()
  }
  
  @MainActor
  open func runIsolated() async {
    await run()
  }
  
  open func run() async {
    for step in steps {
      if step.isApplicable(context: context) {
        await step.run()
      }
    }
  }
  
}
