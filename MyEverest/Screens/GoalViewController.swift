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
  private var colorPickerAlert: AlertManager!
  private var colorPickerView = CommonColorPickerView()

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
    let nameObservable = self.titleTextField.rx.text.asObservable()
    let noteObservable = self.noteTextView.rx.text.asObservable()
    let colorObservable = self.colorPickerView.rx.selectedColor.asObservable().map { color in
      return MaterialColor.instant(with: color)
    }
    let triggerObservable = self.saveButton.rx.tap.asObservable()
    let input = (nameObservable: nameObservable, noteObservable: noteObservable, colorObservable: colorObservable)

    self.viewModel.configure(input: input, triggerObservable: triggerObservable) { errors in
      if let errors = errors {
        AlertManager().showError(errors.localizedDescription)
        return
      }
      self.dismiss(animated: true, completion: nil)
    }

    self.viewModel.validationObserver?
      .bind(to: self.saveButton.rx.isEnabled)
      .addDisposableTo(self.disposeBag)
  }

  override func setupTintColor() {
    super.setupTintColor()

    self.tintColor.asObservable()
      .bind(to: self.colorButton.rx.tintColor)
      .addDisposableTo(self.disposeBag)
  }

  private func setupColorPicker() {
    self.colorPickerAlert = AlertManager(width: self.colorPickerView.frame.width, showCloseButton: false)
    self.colorPickerAlert.customSubview = self.colorPickerView

    Observable.just(MaterialColor.allColors)
      .bind(to: self.colorPickerView.rx.colors)
      .addDisposableTo(self.disposeBag)

    Observable.just(Constant.defaultColor)
      .map { color in
        return MaterialColor.instant(with: color)?.rawValue
      }.bind(to: self.colorPickerView.rx.preselectedIndex)
      .addDisposableTo(self.disposeBag)

    self.colorButton.rx.tap
      .subscribe(onNext: { _ in
        self.colorPickerAlert.showEdit(Constant.colorAlertTitle)
      }).addDisposableTo(self.disposeBag)

    self.colorPickerView.rx.selectedColor.asObservable()
      .unwrap()
      .subscribe(onNext: { color in
        self.tintColor.value = color
        self.colorPickerAlert.close()
      }).addDisposableTo(self.disposeBag)

    self.colorPickerView.rx.selectedColor.asObservable()
      .map { color in
        return MaterialColor.instant(with: color)?.code()
      }.bind(to: self.colorButton.rx.title())
      .addDisposableTo(self.disposeBag)
  }
}
