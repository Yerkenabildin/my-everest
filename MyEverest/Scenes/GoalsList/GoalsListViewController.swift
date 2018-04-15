import UIKit
import RxSwift
import RxCocoa

// sourcery:autoinjectVC = GoalsListViewModelType
final class GoalsListViewController: BaseViewController {

  // MARK: - Params
  private let viewModel: GoalsListViewModelType

  // MARK: - Init
  init(viewModel: GoalsListViewModelType) {
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
