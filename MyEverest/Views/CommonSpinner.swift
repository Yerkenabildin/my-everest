//
//  CommonSpinner.swift
//  BucketList
//
//  Created by  on 5/8/17.
//
//

import UIKit
import RxCocoa
import RxSwift

fileprivate struct Constant {
  static let textColor = ColorConstants.textColor
  static let textTintColor = ColorConstants.tintColor
}

class CommonSpinner<Element: CustomStringConvertible>: CommonTextField {

  private let pickerView = UIPickerView()
  var elements: Variable<[Element]> = Variable([])
  var selectedElement: Variable<Element?> = Variable(nil)
  let disposeBag = DisposeBag()
  var textTintColor = Constant.textTintColor {
    didSet {
      if self.isFirstResponder {
        self.textColor = self.textTintColor
      }
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init() {
    super.init(frame: CGRect.zero)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    self.tintColor = UIColor.clear
    self.inputView = self.pickerView

    self.elements.asObservable()
      .bind(to: self.pickerView.rx.rows()) { _, _, element in
        return element.description
      }.addDisposableTo(self.disposeBag)

    self.pickerView.rx.itemSelected
      .asObservable()
      .map { row, _ in
        return row
      }.withLatestFrom(self.elements.asObservable()) { row, elements in
        return elements.count > row ? elements[row] : nil
      }.bind(to: self.selectedElement)
      .addDisposableTo(self.disposeBag)

    self.selectedElement.asObservable()
      .filter { $0 != nil }
      .map { $0?.description }
      .bind(to: self.rx.text)
      .addDisposableTo(self.disposeBag)
  }

  override func becomeFirstResponder() -> Bool {
    self.textColor = self.textTintColor
    if self.selectedElement.value == nil && self.elements.value.count > 0 {
      self.selectedElement.value = self.elements.value[0]
    }
    return super.becomeFirstResponder()
  }

  override func resignFirstResponder() -> Bool {
    self.textColor = Constant.textColor
    return super.resignFirstResponder()
  }
}
