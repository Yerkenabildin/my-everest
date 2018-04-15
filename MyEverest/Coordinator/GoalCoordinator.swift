import Foundation
import RxSwift
import PopupDialog

final class GoalCoordinator: CoordinatorType, CoordinatorDelegate {

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

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  @discardableResult
  func execute(step: CoordinatorStepType) -> Bool {
    guard let goalStep = step as? GoalStep else {
      return cascade(step: step)
    }
    switch goalStep {
    case .list:
      gotoGoalsList()
    case .create:
      gotoCreateList()
    }
    return true
  }

  func execute<Step, Result>(step: Step) -> Observable<Result?>
    where Step : ObservableCoordinatorStepType, Result == Step.Result {
      fatalError()
  }

  private func gotoGoalsList() {
    let vc = Dependency.shared.resolver.resolveNonNil(GoalsListViewController.self)
    self.navigationController?.pushViewController(vc, animated: true)
  }

  private func gotoCreateList() {
    let vc = Dependency.shared.resolver.resolveNonNil(EditGoalViewController.self)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
