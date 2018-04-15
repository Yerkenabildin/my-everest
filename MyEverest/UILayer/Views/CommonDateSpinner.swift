//
//  CommonDateSpinner.swift
//  BucketList
//
//  Created by  on 5/15/17.
//
//

import UIKit
import RxCocoa
import RxSwift

fileprivate struct Constant {
  static let formate = "dd MMMM yyyy"
  static let textColor = ColorConstants.textColor
  static let textTintColor = ColorConstants.tintColor
}

class CommonDateSpinner: CommonTextField {

  private let datePickerView = UIDatePicker()
  private let disposeBag = DisposeBag()
  var formate = Constant.formate
  var selectedDate: Date? {
    didSet {
      self.sendActions(for: .valueChanged)
    }
  }
  var textTintColor = Constant.textTintColor

  override func awakeFromNib() {
    super.awakeFromNib()
    setupPickerView()
    self.tintColor = UIColor.clear
  }

  private func setupPickerView() {
    self.inputView = self.datePickerView
    self.datePickerView.datePickerMode = UIDatePickerMode.date
    self.datePickerView.rx.date
      .asObservable()
      .skip(1)
      .bind(to: self.rx.selectedDate)
      .disposed(by: self.disposeBag)

    self.rx.selectedDate.asObservable()
      .map { date in
        return date?.toString(withFormate: self.formate)
      }.bind(to: self.rx.text)
      .disposed(by: self.disposeBag)
  }

  override func becomeFirstResponder() -> Bool {
    self.textColor = self.textTintColor
    if self.text == "" {
      self.rx.selectedDate.onNext(self.datePickerView.date)
    }
    return super.becomeFirstResponder()
  }

  override func resignFirstResponder() -> Bool {
    self.textColor = Constant.textColor
    return super.resignFirstResponder()
  }
}

extension Reactive where Base: CommonDateSpinner {
  var selectedDate: ControlProperty<Date?> {
    return UIControl.rx.valuePublic(
      self.base,
      getter: { dateSpinner in
        dateSpinner.selectedDate
    }, setter: { dateSpinner, value in
      dateSpinner.selectedDate = value
    })
  }
}
