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

fileprivate struct Constant {
  static let todoTitle = "To Do"
  static let doneTitle = "Done"
}

class TasksListViewController: BaseViewController {
  typealias SectionData = (title: String, tasks: [Task])

  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private var addButton: UIBarButtonItem!

  fileprivate var data = Variable<[SectionData]>([])
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
      .map { self.split(tasks: $0) }
      .bind(to: self.data)
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

    self.data.asObservable()
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

  // MARK: -
  private func split(tasks: [Task]) -> [SectionData] {
    var result: [SectionData] = []
    let todoTasks = tasks.filter { !$0.isComplete }
    if todoTasks.count > 0 {
      result.append((title: Constant.todoTitle, tasks: todoTasks))
    }
    let doneTasks = tasks.filter { $0.isComplete }
    if doneTasks.count > 0 {
      result.append((title: Constant.doneTitle, tasks: doneTasks))
    }
    return result
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
    let sectionData = self.data.value[section]
    return sectionData.tasks.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath)
      as? TaskTableViewCell else {
        return UITableViewCell()
    }
    let tasks = self.data.value[indexPath.section].tasks
    let task = tasks[indexPath.row]
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

  func numberOfSections(in tableView: UITableView) -> Int {
    return self.data.value.count
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.data.value[section].title
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return TaskTableViewCell.height
  }
}
