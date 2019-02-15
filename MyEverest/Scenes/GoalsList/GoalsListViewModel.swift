import Foundation
import RxSwift
import RxCocoa

protocol GoalsListViewModelInputs {
  func createNewGoal()
}
protocol GoalsListViewModelOutputs {
  var goalsDriver: Driver<[Goal]> { get }
}

protocol GoalsListViewModelType: ViewModelType {
  var inputs: GoalsListViewModelInputs { get }
  var outputs: GoalsListViewModelOutputs { get }
}

// sourcery: autoinject
final class GoalsListViewModel: BaseViewModel, GoalsListViewModelType, GoalsListViewModelInputs, GoalsListViewModelOutputs {

  private let goalService: GoalServiceType

  init(goalService: GoalServiceType) {
    self.goalService = goalService
    super.init()
  }

  private(set) lazy var goalsDriver = self.goalService.goalsObservable.asDriver(onErrorJustReturn: [])

  func createNewGoal() {
//    self.steps.accept(GoalStep.create)
  }

  var inputs: GoalsListViewModelInputs { return self }
  var outputs: GoalsListViewModelOutputs { return self }

}
