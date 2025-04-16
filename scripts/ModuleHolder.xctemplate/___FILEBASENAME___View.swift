//
//  ___FILEHEADER___
//
import SwiftUI
import HuddleArch

struct ___VARIABLE_moduleName:identifier___View: View {
  @Environment(\.scenePhase) var scenePhase

  let module: ___VARIABLE_moduleName:identifier___Module
  let router: ___VARIABLE_moduleName:identifier___Routing
  @State var viewModel: ___VARIABLE_moduleName:identifier___ViewModel
  
  var body: some View {
    Text("")
  }
}

struct ___VARIABLE_moduleName:identifier___View_Previews: PreviewProvider {
  static let module = ___VARIABLE_moduleHolderClassName:identifier___(context: ___VARIABLE_moduleHolderContextClass:identifier___(), component: ___VARIABLE_moduleName:identifier___ModuleComponentImpl())
  static let router: ___VARIABLE_moduleName:identifier___Router? = ___VARIABLE_moduleName:identifier___Builder.buildRouter(component: ___VARIABLE_moduleName:identifier___ViewComponentImpl(module: module, moduleHolder: module))
  
  static var previews: some View {
    router!.rootView()
      .preview()
  }
}
