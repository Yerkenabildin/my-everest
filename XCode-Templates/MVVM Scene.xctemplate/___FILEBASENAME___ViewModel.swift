import Foundation
import RxSwift
import RxCocoa

protocol ___FILEBASENAMEASIDENTIFIER___Inputs { }
protocol ___FILEBASENAMEASIDENTIFIER___Outputs { }

protocol ___FILEBASENAMEASIDENTIFIER___Type: ViewModelType {
  var inputs: ___FILEBASENAMEASIDENTIFIER___Inputs { get }
  var outputs: ___FILEBASENAMEASIDENTIFIER___Outputs { get }
}

// sourcery: autoinject
final class ___FILEBASENAMEASIDENTIFIER___: BaseViewModel, ___FILEBASENAMEASIDENTIFIER___Type, ___FILEBASENAMEASIDENTIFIER___Inputs, ___FILEBASENAMEASIDENTIFIER___Outputs {
  var coordinator: CoordinatorType?

  var inputs: ___FILEBASENAMEASIDENTIFIER___Inputs { return self }
  var outputs: ___FILEBASENAMEASIDENTIFIER___Outputs { return self }

}
