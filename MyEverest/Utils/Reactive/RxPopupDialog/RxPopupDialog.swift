import Foundation
import RxSwift
import PopupDialog

enum PopupDialogStyle {
  case cancel
  case destructive
  case `default`
}

protocol RxPopupDialogActionType {
  associatedtype Result

  var title: String { get }
  var style: PopupDialogStyle { get }
  var result: Result? { get }
}

struct RxPopupDialogAction<R>: RxPopupDialogActionType {
  typealias Result = R

  let title: String
  var style = PopupDialogStyle.default
  let result: R?
}

struct RxPopupDialogDefaultAction: RxPopupDialogActionType {
  typealias Result = Void

  let title: String
  var style = PopupDialogStyle.default
  let result: Result? = nil

  init(title: String) {
    self.title = title
  }
}

extension Reactive where Base: PopupDialog {

  static func present<Action: RxPopupDialogActionType, Result>(
    viewController: UIViewController,
    title: String? = nil,
    message: String? = nil,
    animated: Bool = true,
    actions: [Action]) -> Observable<Result?> where Action.Result == Result {
    return Observable.create { observer -> Disposable in
      let popupDialog = PopupDialog(title: title, message: message)
      for action in actions {
        let button: PopupDialogButton
        let callback = {
          observer.onNext(action.result)
          observer.onCompleted()
        }
        switch action.style {
        case .cancel:
          button = CancelButton(title: action.title, height: 50, action: callback)
        case .destructive:
          button = DestructiveButton(title: action.title, height: 50, action: callback)
        default:
          button = DefaultButton(title: action.title, height: 50, action: callback)
        }
        popupDialog.addButton(button)
      }
      viewController.present(popupDialog, animated: animated, completion: nil)
      return Disposables.create {
        popupDialog.dismiss(animated: animated, completion: nil)
      }
    }
  }
}
