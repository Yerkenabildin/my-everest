import Foundation
import Swinject

final class ViewModelAssembly: Assembly {
  func assemble(container: Container) {
    // sourcery:inline:ViewModel.AutoInject
    container.register(EditGoalViewModelType.self) { (r) in
      let vm = EditGoalViewModel()
      vm.coordinator = r.resolve(CoordinatorType.self)
      return vm
    }
    container.register(GoalInfoViewModelType.self) { (r) in
      let vm = GoalInfoViewModel()
      vm.coordinator = r.resolve(CoordinatorType.self)
      return vm
    }
    container.register(GoalsListViewModelType.self) { (r) in
      let vm = GoalsListViewModel()
      vm.coordinator = r.resolve(CoordinatorType.self)
      return vm
    }
    // sourcery:end
  }
}
