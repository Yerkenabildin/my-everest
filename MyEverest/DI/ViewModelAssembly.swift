import Foundation
import Swinject

final class ViewModelAssembly: Assembly {
  func assemble(container: Container) {
    // sourcery:inline:ViewModel.AutoInject
    container.register(EditGoalViewModelType.self) { (r) in
      let vm = EditGoalViewModel(goalService: r.resolve(GoalServiceType.self)!)
      return vm
    }
    container.register(GoalInfoViewModelType.self) { _ in
      let vm = GoalInfoViewModel()
      return vm
    }
    container.register(GoalsListViewModelType.self) { (r) in
      let vm = GoalsListViewModel(goalService: r.resolve(GoalServiceType.self)!)
      return vm
    }
    // sourcery:end
  }
}
