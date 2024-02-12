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
  var flowModule: FlowModule<FlowContext>? { get }
  var context: FlowContext { get }
  var cancellables: Set<AnyCancellable> { get set }
  func isApplicable(context: FlowContext) -> Bool
  func run()
  func onNext()
}

open class Flow<FlowContext>: Flowing {
  public weak var flowModule: FlowModule<FlowContext>?
  public let context: FlowContext
  public var cancellables: Set<AnyCancellable> = []
  
  public init(flowModule: FlowModule<FlowContext>, context: FlowContext) {
    self.flowModule = flowModule
    self.context = context
  }
  
  open func isApplicable(context: FlowContext) -> Bool {
    true
  }
  
  open func run() {}
  
  open func onNext() {
    flowModule?.onNext()
    
    cancellables.forEach { $0.cancel() }
    cancellables = []
  }
}


public extension AnyCancellable {
  func disposeOnNext<T: Flowing>(flow: T) {
    self.store(in: &flow.cancellables)
  }
}
