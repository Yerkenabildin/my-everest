import UIKit
import RxSwift
import RxCocoa

// sourcery:autoinjectVC = GoalInfoViewModelType
final class GoalInfoViewController: BaseViewController {

  // MARK: - Params
  private let viewModel: GoalInfoViewModelType

  // MARK: - Init
  init(viewModel: GoalInfoViewModelType) {
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
