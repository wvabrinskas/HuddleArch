//
//  Routing.swift
//  Huddle
//
//  Created by William Vabrinskas on 2/3/23.
//

import Foundation
import SwiftUI

public protocol Routing: AnyObject {
  @MainActor
  func rootView() -> any View
}

open class Router: Routing {
  
  public init() {}
  // Override to provide root view
  @MainActor
  open func rootView() -> any View {
    EmptyView()
  }
}
