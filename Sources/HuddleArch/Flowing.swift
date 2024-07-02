//
//  Flowing.swift
//  Huddle
//
//  Created by William Vabrinskas on 5/26/23.
//

import Foundation
import Combine

public protocol Flowing: AnyObject {
  associatedtype FlowContext
  associatedtype FlowResultObject: FlowResult
  var flowModule: FlowModule<FlowContext, FlowResultObject>? { get }
  var context: FlowContext { get }
  var cancellables: Set<AnyCancellable> { get set }
  
  func isApplicable(context: FlowContext) -> Bool
  func run() async
  func run(flowResult: FlowResultObject?) async -> FlowResultObject?
  func onNext()
}

open class Flow<FlowContext, FlowResultObject: FlowResult>: Flowing {
  public weak var flowModule: FlowModule<FlowContext, FlowResultObject>?
  public let context: FlowContext
  public var cancellables: Set<AnyCancellable> = []
  
  public init<FComponent: Component>(flowModule: FlowModule<FlowContext, FlowResultObject>, context: FlowContext, component: FComponent) {
    self.flowModule = flowModule
    self.context = context
  }
  
  open func isApplicable(context: FlowContext) -> Bool {
    true
  }
  
  open func run() async {}
  
  open func run(flowResult: FlowResultObject? = nil) async -> FlowResultObject? {
    if let flowResult {
      return flowModule?.result?.updating(flowResult)
    }
    
    return nil
  }
  
  open func onNext() {
    cancellables.forEach { $0.cancel() }
    cancellables = []
  }
}


public extension AnyCancellable {
  func disposeOnNext<T: Flowing>(flow: T) {
    self.store(in: &flow.cancellables)
  }
}
