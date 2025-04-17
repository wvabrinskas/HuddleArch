//
//  ___FILEHEADER___
//

import Foundation
import SwiftUI
import HuddleArch

public struct ___VARIABLE_productName:identifier___View: View {
  
  @Environment(\.theme) var theme
  let router:  ___VARIABLE_productName:identifier___Routing
  var module: any ___VARIABLE_productName: identifier___Supporting
  var moduleHolder: ModuleHolding?

  @State var viewModel: ___VARIABLE_productName:identifier___ViewModel

  public var body: some View {
    VStack {
      Text("Some Text")
    }
  }
}

struct ___VARIABLE_productName:identifier___View_Previews: PreviewProvider {
  static let context = ___VARIABLE_parentModuleHolderContextClass:identifier___()
  static let rootComponent =  ___VARIABLE_parentComponentClass:identifier___Impl()
  static let moduleHolder = ___VARIABLE_parentModuleHolderClassName:identifier___(context: context, component: rootComponent)

  static let module = ___VARIABLE_productName: identifier___Builder.build(parentComponent: rootComponent, holder: moduleHolder, context: context)

  static var previews: some View {
    module.router!.rootView()
      .preview()
  }
}
