//
//  FlowTests.swift
//  
//
//  Created by William Vabrinskas on 7/2/24.
//

import Foundation
import XCTest
import SwiftUI
@testable import HuddleArch


struct TestFlowContext {
  
}

struct TestFlowResult: FlowResult, Equatable {
  var title: String?
  var name: String?
  
  init(title: String? = nil, name: String? = nil) {
    self.title = title
    self.name = name
  }
  
  func updating(_ with: TestFlowResult) -> TestFlowResult {
    .init(title: with.title ?? self.title,
          name: with.name ?? self.name)
  }
}


fileprivate final class TestTitleFlow: Flow<TestFlowContext, TestFlowResult> {
  
  override func run(flowResult: TestFlowResult? = nil) async -> TestFlowResult? {
    let newFlowResult = TestFlowResult(title: "title")
    return await super.run(flowResult: newFlowResult)
  }
}

fileprivate final class TestNameFlow: Flow<TestFlowContext, TestFlowResult> {
  
  override func run(flowResult: TestFlowResult? = nil) async -> TestFlowResult? {
    let newFlowResult = TestFlowResult(name: "name")
    return await super.run(flowResult: newFlowResult)
  }
}

fileprivate final class TestFlowModule: FlowModule<TestFlowContext, TestFlowResult> {
  
  override init(context: TestFlowContext, result: (@Sendable () -> TestFlowResult?)? = nil) {
    super.init(context: context, result: result)
    
    self.steps = [
      TestTitleFlow(flowModule: self, context: context, component: EmptyComponent()),
      TestNameFlow(flowModule: self, context: context, component: EmptyComponent())
    ]
  }
}



public class FlowTests: XCTestCase {
  
  fileprivate let flow = TestFlowModule(context: .init()) {
    .init()
  }
  
  func test_resultUpdates() async {
    let expected = TestFlowResult(title: "title", name: "name")
    
    let result: TestFlowResult? = await flow.run()
    
    XCTAssertEqual(expected, result)
  }
}


