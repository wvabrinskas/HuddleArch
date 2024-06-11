//
//  Routing.swift
//  Huddle
//
//  Created by William Vabrinskas on 2/3/23.
//

import Foundation
import SwiftUI

@MainActor
public protocol Routing: AnyObject {
  func rootView() -> any View
}

@MainActor
open class Router: Routing {
  
  public nonisolated init() {
    // no op
  }
  
  // Override to provide root view
  open func rootView() -> any View {
    EmptyView()
  }
}
