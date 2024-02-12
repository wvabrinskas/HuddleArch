//
//  ___FILEHEADER___
//

import Foundation
import SwiftUI
import HuddleArch

public struct ___VARIABLE_moduleName:identifier___View: View {
  
  @Environment(\.theme) var theme
  let router:  ___VARIABLE_moduleName:identifier___Routing
  var module: any ___VARIABLE_moduleName: identifier___Supporting
  var moduleHolder: ModuleHolding?

  public var body: some View {
    VStack {
      Text("Some Text")
    }
    .fullscreen()
    .applyThemeBackground()
    .logImpression(name: "___VARIABLE_moduleName:identifier___View")
  }
}

struct ___VARIABLE_moduleName:identifier___View_Previews: PreviewProvider {
  static let context = ___VARIABLE_parentModuleHolderContextClass:identifier___()
  static let rootComponent =  ___VARIABLE_parentComponentClass:identifier___Impl()
  static let moduleHolder = ___VARIABLE_parentModuleHolderClassName:identifier___(context: context, component: rootComponent)

  static let module = ___VARIABLE_moduleName: identifier___Builder().build(parentComponent: rootComponent, holder: moduleHolder, context: context)

  static var previews: some View {
    module.router!.rootView()
      .preview()
  }
}
