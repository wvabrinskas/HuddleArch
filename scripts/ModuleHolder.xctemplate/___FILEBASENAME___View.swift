//
//  ___FILEHEADER___
//
import SwiftUI
import HuddleArch

struct ___VARIABLE_productName:identifier___View: View {
  @Environment(\.scenePhase) var scenePhase

  let module: ___VARIABLE_productName:identifier___Supporting
  let router: ___VARIABLE_productName:identifier___Routing
  @State var viewModel: ___VARIABLE_productName:identifier___ViewModel

  var body: some View {
    Text("")
  }
}

struct ___VARIABLE_productName:identifier___View_Previews: PreviewProvider {
  static let module = ___VARIABLE_productName:identifier___ModuleHolder(context: ___VARIABLE_productName:identifier___ModuleHolderContext(), component: ___VARIABLE_productName:identifier___ModuleComponentImpl())
  static let router: ___VARIABLE_productName:identifier___Router? = ___VARIABLE_productName:identifier___Builder.buildRouter(component: ___VARIABLE_productName:identifier___ViewComponentImpl(module: module, moduleHolder: module))
  
  static var previews: some View {
    router!.rootView()
      .preview()
  }
}
