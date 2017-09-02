//
//  NewGroupViewController.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 25.04.17.
//
//

import UIKit
import RxSwift
import RxCocoa

fileprivate struct Constant {
  static let colorAlertTitle = "Choose color"
  static let titlePlaceholder = "Goal title"
  static let notePlaceholder = "Description..."
  static let defaultColor = ColorConstants.tintColor
}

class GoalViewController: ObjectViewController {

  @IBOutlet private var colorButton: UIButton!
  var viewModel = GoalViewModel()
  private lazy var colorPickerView = CommonColorPickerView()
  private lazy var colorPickerAlert: AlertManager = {
    let alertManager = AlertManager(width: self.colorPickerView.frame.width, showCloseButton: false)
    alertManager.customSubview = self.colorPickerView
    return alertManager
  }()

  // MARK: - Setup
  override func setup() {
    super.setup()
    setupViewModel()
    setupTexts()
    setupTintColor()
    setupColorPicker()
  }

  override func setupTexts() {
    self.titleTextField.placeholder = Constant.titlePlaceholder
    self.noteTextView.placeholder = Constant.notePlaceholder
  }

  private func setupViewModel() {
    self.titleTextField.rx.text.asObservable()
      .bind(to: self.viewModel.nameSubject)
      .addDisposableTo(self.disposeBag)

    self.noteTextView.rx.text.asObservable()
      .bind(to: self.viewModel.noteSubject)
      .addDisposableTo(self.disposeBag)

    self.colorPickerView.rx.selectedColor.asObservable().map {
        MaterialColor.instant(with: $0)
      }.bind(to: self.viewModel.colorSubject)
      .addDisposableTo(self.disposeBag)

    self.saveButton.rx.tap.asObservable()
      .bind(to: self.viewModel.saveTriggerSubject)
      .addDisposableTo(self.disposeBag)

    self.viewModel.compliteObsrvable?
      .filter { $0 == nil }
      .subscribe(onNext: { _ in
        self.dismiss(animated: true, completion: nil)
      }).addDisposableTo(self.disposeBag)

    self.viewModel.compliteObsrvable?
      .map { $0?.localizedDescription }
      .unwrap()
      .bind(to: AlertManager().rx.showError())
      .addDisposableTo(self.disposeBag)
  }

  override func setupTintColor() {
    super.setupTintColor()
    self.tintColor.asObservable()
      .bind(to: self.colorButton.rx.tintColor)
      .addDisposableTo(self.disposeBag)
  }

  private func setupColorPicker() {
    Observable.just(MaterialColor.allColors)
      .bind(to: self.colorPickerView.rx.colors)
      .addDisposableTo(self.disposeBag)

    Observable.just(Constant.defaultColor)
      .map { MaterialColor.instant(with: $0)?.rawValue }
      .bind(to: self.colorPickerView.rx.preselectedIndex)
      .addDisposableTo(self.disposeBag)

    self.colorButton.rx.tap
      .map { Constant.colorAlertTitle }
      .bind(to: self.colorPickerAlert.rx.showEdit())
      .addDisposableTo(self.disposeBag)

    self.colorPickerView.rx.selectedColor.asObservable()
      .unwrap()
      .subscribe(onNext: { color in
        self.tintColor.value = color
        self.colorPickerAlert.close()
      }).addDisposableTo(self.disposeBag)

    self.colorPickerView.rx.selectedColor.asObservable()
      .map { MaterialColor.instant(with: $0)?.code() }
      .bind(to: self.colorButton.rx.title())
      .addDisposableTo(self.disposeBag)
  }
}
