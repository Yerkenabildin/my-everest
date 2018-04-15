import Foundation
import RxSwift
import PopupDialog

final class AppCoordinator: CoordinatorType, CoordinatorDelegate {

  weak var delegate: CoordinatorDelegate?
  var childCoordinators: [CoordinatorType] = []
  weak var navigationController: UINavigationController?

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
    guard let appStep = step as? AppStep else {
      return cascade(step: step)
    }
    switch appStep {
    case .home:
      gotoHome()
    default:
      break
    }
    return true
  }

  func execute<Step, Result>(step: Step) -> Observable<Result?>
    where Step : ObservableCoordinatorStepType, Result == Step.Result {
      fatalError()
  }

  private func gotoHome() {
    let homeVC = Dependency.shared.resolver.resolveNoNil(GoalsListViewController.self)
    let navigationController = UINavigationController(rootViewController: homeVC)
    self.root = navigationController
    self.navigationController = navigationController
  }
}
