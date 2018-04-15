import Foundation
import RxSwift
import RxCocoa

protocol EditGoalViewModelInputs { }
protocol EditGoalViewModelOutputs { }

protocol EditGoalViewModelType: ViewModelType {
  var inputs: EditGoalViewModelInputs { get }
  var outputs: EditGoalViewModelOutputs { get }
}

// sourcery: autoinject
final class EditGoalViewModel: BaseViewModel, EditGoalViewModelType, EditGoalViewModelInputs, EditGoalViewModelOutputs {

  var coordinator: CoordinatorType?
  private let goalService: GoalServiceType

  init(goalService: GoalServiceType) {
    self.goalService = goalService
    super.init()
  }

  var inputs: EditGoalViewModelInputs { return self }
  var outputs: EditGoalViewModelOutputs { return self }
}
