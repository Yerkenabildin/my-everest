import Foundation
import RxSwift
import RxFlow

final class AppFlow: Flow {

  var root: Presentable {
    return rootWindow
  }

  private let rootWindow: UIWindow

  init(with window: UIWindow) {
    self.rootWindow = window
  }

  func navigate(to step: Step) -> NextFlowItems {
    guard let step = step as? AppStep else {
      return NextFlowItems.none
    }
    switch step {
    case .home:
      return navigationToHome()
    }
  }

  private func navigationToHome() -> NextFlowItems {
    let navigationController = UINavigationController()
    self.rootWindow.rootViewController = navigationController
    let goalsFlow = GoalsFlow(with: navigationController)
    Flows.whenReady(flow1: goalsFlow) { [unowned self] root in
      self.rootWindow.rootViewController = root
    }
    let flowItem = NextFlowItem(nextPresentable: goalsFlow,
                                nextStepper: OneStepper(withSingleStep: GoalStep.list))
    return NextFlowItems.one(flowItem: flowItem)
  }
}
