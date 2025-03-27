//
//  Flowing.swift
//  Huddle
//
//  Created by William Vabrinskas on 5/26/23.
//

import Foundation
import Combine

public protocol FlowStepping: AnyObject {
  associatedtype FlowContext
  associatedtype FlowComponent: ComponentProviding
  associatedtype FlowResultObject: FlowResult
  var flow: Flow<FlowContext, FlowComponent, FlowResultObject>? { get }
  var context: FlowContext { get }
  var cancellables: Set<AnyCancellable> { get set }
  
  func isApplicable(context: FlowContext) -> Bool
  func run() async
  func run(flowResult: FlowResultObject?) async -> FlowResultObject?
  func onNext()
}

open class FlowStep<FlowContext, FlowComponent: ComponentProviding, FlowResultObject: FlowResult>: FlowStepping {
  public weak var flow: Flow<FlowContext, FlowComponent, FlowResultObject>?
  public let context: FlowContext
  public var cancellables: Set<AnyCancellable> = []
  
  public init(flow: Flow<FlowContext, FlowComponent, FlowResultObject>, context: FlowContext, component: FlowComponent) {
    self.flow = flow
    self.context = context
  }
  
  open func isApplicable(context: FlowContext) -> Bool {
    true
  }
  
  open func run() async {}
  
  open func run(flowResult: FlowResultObject? = nil) async -> FlowResultObject? {
    if let flowResult {
      return flow?.result?.updating(flowResult)
    }
    
    return nil
  }
  
  open func onNext() {
    cancellables.forEach { $0.cancel() }
    cancellables = []
  }
}


public extension AnyCancellable {
  func disposeOnNext<T: FlowStepping>(flow: T) {
    self.store(in: &flow.cancellables)
  }
}
