import Foundation
import RxSwift
import RxFlow
import PopupDialog

//final class PopupFlow: Flow {
//
//  var root: Presentable {
//    return self.popupDialog
//  }
//
//  private var viewController: UIViewController
//  private var popupDialog = PopupDialog(title: "", message: "")
//
//  init(with viewController: UIViewController) {
//    self.viewController = viewController
//    Log.initOf(self)
//  }
//
//  func navigate(to step: Step) -> NextFlowItems {
//    guard let step = step as? PopupStep else {
//      return .none
//    }
//    switch step {
//    case .error(let error):
//      return presentErrorPopup(error)
//    case .dismiss:
//      self.popupDialog.dismiss()
//      return .end(forwardToParentFlowWithStep: NoneStep())
//    }
//  }
//
//  private func presentErrorPopup(_ error: Error) -> NextFlowItems {
//    let popupDialog = PopupDialog(title: EvLocalization.error(), message: error.localizedDescription)
//    let button = DefaultButton(title: EvLocalization.ok(),
//                               height: Constant.popupDialog.buttonHeight) { [weak popupDialog] in
//                                popupDialog?.steps.accept(PopupStep.dismiss)
//    }
//    popupDialog.addButton(button)
//    self.popupDialog = popupDialog
//    self.viewController.present(self.popupDialog, animated: true)
//    return NextFlowItems.one(flowItem: NextFlowItems(nextPresentable: popupDialog, nextStepper: popupDialog))
//  }
//
//  deinit {
//    Log.deinitOf(self)
//  }
//}

//extension PopupDialog: Stepper {
//    public var steps: PublishRelay<Step> {
//
//    }
//}
