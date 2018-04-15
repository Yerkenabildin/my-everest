import UIKit
import RxSwift
import RxCocoa

// sourcery:autoinjectVC = ___VARIABLE_productName:identifier___ViewModelType
final class ___FILEBASENAMEASIDENTIFIER___: BaseViewController {

  // MARK: - Params
  private let viewModel: ___VARIABLE_productName:identifier___ViewModelType

  // MARK: - Init
  init(viewModel: ___VARIABLE_productName:identifier___ViewModelType) {
    self.viewModel = viewModel
    super.init()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError(.noImplementation)
  }

  // MARK: - Setup
  override func setupUI() {

  }

  // MARK: - Bind
  override func bindViewModel() {
    self.viewModel.bindActivityIndicator()
    self.viewModel.bindErrorTracker()
  }

  override func bindStyles() {

  }
}
