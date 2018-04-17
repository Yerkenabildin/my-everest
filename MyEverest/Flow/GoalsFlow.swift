import Foundation
import RxSwift
import RxFlow

final class GoalsFlow: Flow {

  var root: Presentable {
    return self.navigationController
  }

  var navigationController: UINavigationController

  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func navigate(to step: Step) -> NextFlowItems {
    guard let goalStep = step as? GoalStep else {
      return cascade(step: step)
    }
    switch goalStep {
    case .list:
      return navigationToGoalsList()
    case .create:
      return navigationToCreateList()
    }
  }

  private func navigationToGoalsList() -> NextFlowItems {
    let vc = Dependency.shared.resolver.resolveNonNil(GoalsListViewController.self)
    self.navigationController.pushViewController(vc, animated: true)
    return NextFlowItems.one(flowItem: NextFlowItem(nextPresentable: vc, nextStepper: vc.viewModel))
  }

  private func navigationToCreateList() -> NextFlowItems {
    let vc = Dependency.shared.resolver.resolveNonNil(EditGoalViewController.self)
    self.navigationController.pushViewController(vc, animated: true)
    return NextFlowItems.one(flowItem: NextFlowItem(nextPresentable: vc, nextStepper: vc.viewModel))
  }
}
