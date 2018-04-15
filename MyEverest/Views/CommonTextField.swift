//
//  CommonTextField.swift
//  BucketList
//
//  Created by  on 5/8/17.
//
//

import UIKit

fileprivate struct Constant {
  static let textColor = ColorConstants.textColor
  static let placeholderColor = ColorConstants.placeholderColor
  static let font = FontConstants.regular()
}

class CommonTextField: UITextField {
    let attributes = [NSAttributedStringKey.foregroundColor: Constant.placeholderColor]
  var placeholderColor: UIColor = Constant.placeholderColor {
    didSet {
      guard let placeholder = self.placeholder else {
        return
      }
      self.attributedPlaceholder = NSAttributedString(string: placeholder,
        attributes: self.attributes)
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  private func commonInit() {
    self.font = Constant.font
    self.textColor = Constant.textColor
    self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
      attributes: self.attributes)
  }
}
