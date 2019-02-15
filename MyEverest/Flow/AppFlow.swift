import Foundation
import RxSwift
import RxFlow

//final class AppFlow: Flow {
//
//  var root: Presentable {
//    return rootWindow
//  }
//
//  private let rootWindow: UIWindow
//
//  init(with window: UIWindow) {
//    self.rootWindow = window
//  }
//
//  func navigate(to step: Step) -> FlowContributors {
//    guard let appStep = step as? AppStep else {
//       return cascade(step: step)
//    }
//    switch appStep {
//    case .home:
//      return navigationToHome()
//    }
//  }
//
//  private func navigationToHome() -> FlowContributors {
//    let navigationController = UINavigationController()
//    self.rootWindow.rootViewController = navigationController
//    let goalsFlow = GoalsFlow(with: navigationController)
//    Flows.whenReady(flow1: goalsFlow) { [unowned self] root in
//      self.rootWindow.rootViewController = root
//    }
//    let flowItem = FlowContributors(nextPresentable: goalsFlow,
//                                nextStepper: OneStepper(withSingleStep: GoalStep.list))
//    return FlowContributors.one(flowItem: flowItem)
//  }
//}
