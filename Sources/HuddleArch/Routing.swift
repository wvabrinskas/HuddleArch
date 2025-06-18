//
//  Routing.swift
//  Huddle
//
//  Created by William Vabrinskas on 2/3/23.
//

import Foundation
import SwiftUI

public protocol AutoBuildingRouting {
  static var description: String { get }
}

extension AutoBuildingRouting {
  public static var description: String {
    String(describing: Self.Type.self)
  }
}

@MainActor
public protocol Routing: AnyObject {
  func rootView() -> any View
}

@MainActor
open class Router: Routing {
  
  public init() {
    // no op
  }
  
  // Override to provide root view
  open func rootView() -> any View {
    EmptyView()
  }
}
