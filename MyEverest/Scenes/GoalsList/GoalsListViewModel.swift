import Foundation
import RxSwift
import RxCocoa

protocol GoalsListViewModelInputs { }
protocol GoalsListViewModelOutputs { }

protocol GoalsListViewModelType: ViewModelType {
  var inputs: GoalsListViewModelInputs { get }
  var outputs: GoalsListViewModelOutputs { get }
}

// sourcery: autoinject
final class GoalsListViewModel: BaseViewModel, GoalsListViewModelType, GoalsListViewModelInputs, GoalsListViewModelOutputs {
  var coordinator: CoordinatorType?

  var inputs: GoalsListViewModelInputs { return self }
  var outputs: GoalsListViewModelOutputs { return self }

}
