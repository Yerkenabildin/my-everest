//
//  GoalViewController.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 25.04.17.
//
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

fileprivate struct Constant {
  static let calendarTitle = "Choose deadline"
  static let storyboardName = "Create"
  static let titlePlaceholder = "Task title"
  static let notePlaceholder = "Description..."
  static let deadlinePlaceholder = "Deadline"
  static let doneDatePlaceholder = "Complited date"
  static let pointsPlaceholder = "Value"
  static let groupPlaceholder = "Group"
}

class TaskViewController: ObjectViewController {

  @IBOutlet private var deadlineSelector: CommonDateSpinner!
  @IBOutlet private var doneDateSelector: CommonDateSpinner!
  @IBOutlet private var doneDateView: UIView!
  private var pointsSpinner = CommonSpinner<Int>()
  var viewModel: TaskViewModel!

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fillFields()
  }

  // MARK: - Setup
  override func setup() {
    super.setup()
    setupViewModel()
  }

  override func setupTexts() {
    self.deadlineSelector.placeholder = Constant.deadlinePlaceholder
    self.titleTextField.placeholder = Constant.titlePlaceholder
    self.noteTextView.placeholder = Constant.notePlaceholder
    self.pointsSpinner.placeholder = Constant.pointsPlaceholder
    self.doneDateSelector.placeholder = Constant.doneDatePlaceholder
  }

  func setupViewModel() {
//    TODO: -
//    self.titleTextField.rx.text.asObservable()
//      .unwrap()
//      .distinctUntilChanged()
//      .subscribe(onNext: { text in
//        self.viewModel.task.value.name = text
//      }).addDisposableTo(self.disposeBag)
//
//    self.noteTextView.rx.text.asObservable()
//      .unwrap()
//      .distinctUntilChanged()
//      .subscribe(onNext: { text in
//        self.viewModel.task.value.note = text
//      }).addDisposableTo(self.disposeBag)
//
//    self.doneDateSelector.rx.selectedDate.asObservable()
//      .unwrap()
//      .distinctUntilChanged()
//      .subscribe(onNext: { date in
//        self.viewModel.task.value.doneDate = date
//      }).addDisposableTo(self.disposeBag)
//
//    self.deadlineSelector.rx.selectedDate.asObservable()
//      .unwrap()
//      .distinctUntilChanged()
//      .subscribe(onNext: { date in
//        self.viewModel.task.value.dueDate = date
//      }).addDisposableTo(self.disposeBag)
//
//    self.saveButton.rx.tap.asObservable()
//      .subscribe {
//        self.viewModel.saveChanges()
//      }.addDisposableTo(self.disposeBag)
  }

  private func fillFields() {
//    TODO: -
//    self.viewModel.colorObsrvable
//      .unwrap()
//      .distinctUntilChanged()
//      .bind(to: self.tintColor)
//      .addDisposableTo(self.disposeBag)
//
//    self.viewModel.task.asObservable()
//      .map { $0.name }
//      .bind(to: self.titleTextField.rx.text)
//      .addDisposableTo(self.disposeBag)
//
//    self.viewModel.task.asObservable()
//      .map { $0.note }
//      .subscribe(onNext: { text in
//        self.noteTextView.text = text
//      }).addDisposableTo(self.disposeBag)
//
//    self.viewModel.task.asObservable()
//      .map { $0.doneDate }
//      .unwrap()
//      .do {
//        self.doneDateView.isHidden = false
//      }.bind(to: self.doneDateSelector.rx.selectedDate)
//      .addDisposableTo(self.disposeBag)
//
//    self.viewModel.task.asObservable()
//      .map { $0.dueDate }
//      .unwrap()
//      .do {
//        self.doneDateView.isHidden = false
//      }.bind(to: self.deadlineSelector.rx.selectedDate)
//      .addDisposableTo(self.disposeBag)
  }

  override func setupTintColor() {
    super.setupTintColor()
    self.tintColor.asObservable()
      .subscribe(onNext: { color in
        self.pointsSpinner.textTintColor = color
        self.deadlineSelector.textTintColor = color
        self.doneDateSelector.textTintColor = color
      }).addDisposableTo(self.disposeBag)
  }
}
