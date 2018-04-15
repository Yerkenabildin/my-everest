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

  var inputs: EditGoalViewModelInputs { return self }
  var outputs: EditGoalViewModelOutputs { return self }

}
