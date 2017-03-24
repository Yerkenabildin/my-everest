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
    let nameObservable = self.titleTextField.rx.text.asObservable()
    let noteObservable = self.noteTextView.rx.text.asObservable()
    let doneDateObservable = self.doneDateSelector.rx.selectedDate.asObservable()
    let deadlineObservable = self.deadlineSelector.rx.selectedDate.asObservable()
    let triggerObservable = self.saveButton.rx.tap.asObservable()
    let input = (nameObservable: nameObservable, noteObservable: noteObservable,
      doneDateObservable: doneDateObservable, deadlineObservable: deadlineObservable)

    self.viewModel.configure(input: input, triggerObservable: triggerObservable) { errors in
      if let errors = errors {
        AlertManager().showError(errors.localizedDescription)
        return
      }
      self.dismiss(animated: true, completion: nil)
    }

    self.viewModel.colorObsrvable
      .unwrap()
      .bind(to: self.tintColor)
      .addDisposableTo(self.disposeBag)
  }

  private func fillFields() {
    guard let task = self.viewModel.task else {
      self.doneDateView.isHidden = true
      return
    }
    self.doneDateView.isHidden = false
    self.titleTextField.text = task.name
    self.noteTextView.text = task.note
    self.deadlineSelector.selectedDate = task.dueDate
    self.doneDateSelector.selectedDate = task.doneDate
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
