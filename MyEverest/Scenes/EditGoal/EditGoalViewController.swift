import UIKit
import RxSwift
import RxCocoa

// sourcery:autoinjectVC = EditGoalViewModelType
final class EditGoalViewController: BaseViewController {

  // MARK: - Params
  private let viewModel: EditGoalViewModelType

  // MARK: - Init
  init(viewModel: EditGoalViewModelType) {
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
