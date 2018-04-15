//
//  CommonTextView.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 13.05.17.
//
//

import UIKit
import RxCocoa
import RxSwift
import RxSwiftExt

fileprivate struct Constant {
  static let textColor = ColorConstants.textColor
  static let placeholderColor = ColorConstants.placeholderColor.withAlphaComponent(0.5)
  static let font = FontConstants.regular()
}

class CommonTextView: UIView {
  fileprivate var textView: UITextView!
  var placeholder: String? {
    didSet {
//      self.textView.placehol = self.placeholder
      self.textView.text = self.placeholder
      self.textView.textColor = Constant.placeholderColor
    }
  }
  var text: String? {
    didSet {
      if textView.textColor == Constant.placeholderColor
        && self.text != self.placeholder {
          textView.text = self.text
          textView.textColor = Constant.textColor
      }
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

  // MARK: - Setup
  private func commonInit() {
    self.backgroundColor = UIColor.clear
    self.textView = UITextView(frame: self.bounds)
    self.textView.delegate = self
    self.textView.font = Constant.font
    self.textView.textColor = Constant.textColor
    self.textView.isScrollEnabled = false
    self.textView.bounces = false
    self.addSubview(self.textView)
    self.textView.setupMatchParentConstraints()
  }
}

extension CommonTextView: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == Constant.placeholderColor {
      textView.text = nil
      textView.textColor = Constant.textColor
    }
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = self.placeholder
      textView.textColor = Constant.placeholderColor
    }
  }
}

extension Reactive where Base: CommonTextView {
  var text: Observable<String?> {
    return base.textView.rx.text.asObservable()
      .startWith(nil)
      .ignoreWhen {$0 == self.base.placeholder}
      .share()
  }
}
