import Foundation
import RxSwift
import PopupDialog

final class AppCoordinator: CoordinatorType, CoordinatorDelegate {

  weak var delegate: CoordinatorDelegate?
  var childCoordinators: [CoordinatorType] = []

  var window: UIWindow? {
    return UIApplication.shared.keyWindow
  }

  var root: UIViewController? {
    get {
      return self.window?.rootViewController
    }
    set {
      self.window?.rootViewController = newValue
    }
  }

  @discardableResult
  func execute(step: CoordinatorStepType) -> Bool {
    return true
  }

  func execute<Step, Result>(step: Step) -> Observable<Result?>
    where Step : ObservableCoordinatorStepType, Result == Step.Result {
      fatalError()
  }
}
