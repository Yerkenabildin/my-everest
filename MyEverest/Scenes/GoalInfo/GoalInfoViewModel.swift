import Foundation
import RxSwift
import RxCocoa

protocol GoalInfoViewModelInputs { }
protocol GoalInfoViewModelOutputs { }

protocol GoalInfoViewModelType: ViewModelType {
  var inputs: GoalInfoViewModelInputs { get }
  var outputs: GoalInfoViewModelOutputs { get }
}

// sourcery: autoinject
final class GoalInfoViewModel: BaseViewModel, GoalInfoViewModelType, GoalInfoViewModelInputs, GoalInfoViewModelOutputs {

  var inputs: GoalInfoViewModelInputs { return self }
  var outputs: GoalInfoViewModelOutputs { return self }
}
