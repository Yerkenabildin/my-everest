//
//  TasksListViewController.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 19.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TasksListViewController: BaseViewController {

  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private var addButton: UIBarButtonItem!
  fileprivate var tasks = Variable<[Task]>([])
  var viewModel: TasksListViewModel!

  // MARK: - Setup
  override func setup() {
    super.setup()
    setupViewModel()
    setupTableView()
    setupActions()
  }

  private func setupViewModel() {
    self.viewModel.tasksObsrvable
      .bind(to: self.tasks)
      .addDisposableTo(self.disposeBag)

    self.viewModel.colorObsrvable
      .unwrap()
      .bind(to: self.tintColor)
      .addDisposableTo(self.disposeBag)

    self.viewModel.titleObsrvable
      .unwrap()
      .bind(to: self.rx.title)
      .addDisposableTo(self.disposeBag)
  }

  private func setupTableView() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.register(TaskTableViewCell.nib, forCellReuseIdentifier: TaskTableViewCell.identifier)

    self.tasks.asObservable()
      .distinctUntilChanged { $0.count == $1.count }
      .subscribe(onNext: { _ in
        self.tableView.reloadData()
      }).addDisposableTo(self.disposeBag)
  }

  private func setupActions() {
    self.addButton.rx.tap
      .subscribe(onNext: { _ in
        self.gotoCreateTaskViewController()
      }).addDisposableTo(self.disposeBag)
  }

  // MARK: - Go to
  private func gotoCreateTaskViewController() {
    let viewController: TaskViewController = UIStoryboard.instantiate()
    viewController.viewModel = TaskViewModel(with: self.viewModel.goalObservable)
    self.present(viewController, animated: true)
  }
}

// MARK: - UITableViewDataSource
extension TasksListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tasks.value.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath)
      as? TaskTableViewCell else {
        return UITableViewCell()
    }
    let task = self.tasks.value[indexPath.row]
    cell.titleLabel?.text = task.name
    cell.checkBox.isSelected = task.isComplete
    cell.checkBox.rx.isChecked
      .distinctUntilChanged()
      .withLatestFrom(Observable.of(task)) { return ($0, $1) }
      .subscribe(onNext: { isChecked, task in
        self.viewModel.task(task, isChecked: isChecked)
      }).addDisposableTo(cell.disposeBag)

    return cell
  }
}

extension TasksListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return TaskTableViewCell.height
  }
}
