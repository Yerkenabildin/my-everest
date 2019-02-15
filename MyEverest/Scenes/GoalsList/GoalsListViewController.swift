import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources

// sourcery:autoinjectVC = GoalsListViewModelType
final class GoalsListViewController: BaseViewController {

  // MARK: - Params
    let viewModel: GoalsListViewModelType
  private let tableView = UITableView()

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
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    self.navigationItem.rightBarButtonItem = addButton
//    addButton.rx.tap.asDriver()
//      .drive(onNext: self.viewModel.inputs.createNewGoal)
//      .disposed(by: self.disposeBag)

    self.view.addSubview(self.tableView)
    self.tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }

  // MARK: - Bind
  override func bindViewModel() {
    self.viewModel.bindActivityIndicator()
    self.viewModel.bindErrorTracker()

    let dataSource = RxTableViewSectionedAnimatedDataSource<GoalSection>(
      configureCell: { _, tableView, indexPath, goal in
        let identifier = R.reuseIdentifier.goalTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? GoalTableViewCell else {
          fatalError(.nilValue)
        }
        cell.configure(goal)
        return cell
    })

//    self.viewModel.outputs.goalsDriver
//      .map { [GoalSection($0)] }
//      .drive(self.tableView.rx.items(dataSource: dataSource))
//      .disposed(by: self.disposeBag)
  }

  override func bindStyles() {

  }
}
