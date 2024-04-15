//
//  File.swift
//  
//
//  Created by William Vabrinskas on 4/14/24.
//

import Foundation


open class FlowComponent: Component {
  public init(flowModuleComponent: Component) {
    super.init(parent: flowModuleComponent)
  }
}
