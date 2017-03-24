//
//  ViewController.swift
//  BucketList
//
//  Created by  on 3/24/17.
//
//

import UIKit
import RxSwift
import RxCocoa

fileprivate struct Constant {
  static let defaultColor = ColorConstants.tintColor
}

class GoalsListViewController: BaseViewController {

  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private var addButton: UIBarButtonItem!
  fileprivate var goals = Variable<[Goal]>([])
  var viewModel: GoalsListViewModel!

  // MARK: - Lifecycle
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    Observable.just(Constant.defaultColor)
      .bind(to: self.tintColor)
      .addDisposableTo(self.disposeBag)
  }

  // MARK: - Setup
  override func setup() {
    super.setup()
    setupViewModel()
    setupTableView()
    setupActions()
  }

  private func setupViewModel() {
    self.viewModel = GoalsListViewModel()
    self.viewModel.goalsObsrvable
      .bind(to: self.goals)
      .addDisposableTo(self.disposeBag)
  }

  private func setupTableView() {
    self.tableView.dataSource = self

    self.goals.asObservable()
      .subscribe(onNext: { _ in
        self.tableView.reloadData()
      }).addDisposableTo(self.disposeBag)

    self.tableView.rx.itemSelected.asObservable()
      .withLatestFrom(self.goals.asObservable()) { indexPath, goals in
        self.tableView.deselectRow(at: indexPath, animated: true)
        return goals[indexPath.row]
      }.subscribe(onNext: { goal in
        self.gotoTasksListViewController(with: goal)
      }).addDisposableTo(self.disposeBag)
  }

  private func setupActions() {
    self.addButton.rx.tap
      .subscribe(onNext: { _ in
         self.gotoCreateGoalViewController()
      }).addDisposableTo(self.disposeBag)
  }

  // MARK: - Go to
  private func gotoCreateGoalViewController() {
    let viewController: GoalViewController = UIStoryboard.instantiate()
    self.present(viewController, animated: true)
  }

  private func gotoTasksListViewController(with goal: Goal) {
    let viewController: TasksListViewController = UIStoryboard.instantiate()
    viewController.viewModel = TasksListViewModel(from: goal)
    self.navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: - UITableViewDataSource
extension GoalsListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.goals.value.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.identifier)
    let goal = self.goals.value[indexPath.row]
    cell.textLabel?.text = goal.name
    return cell
  }
}
