import Foundation
import Swinject
import Rswift

final class ViewControllerAssembly: Assembly {
  func assemble(container: Container) {
    // sourcery:inline:ViewController.AutoInject
    container.register(EditGoalViewController.self) { r in
      return EditGoalViewController(viewModel: r.resolve(EditGoalViewModelType.self)!)
    }
    container.register(GoalInfoViewController.self) { r in
      return GoalInfoViewController(viewModel: r.resolve(GoalInfoViewModelType.self)!)
    }
    container.register(GoalsListViewController.self) { r in
      return GoalsListViewController(viewModel: r.resolve(GoalsListViewModelType.self)!)
    }
    // sourcery:end
  }
}
