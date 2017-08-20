//
//  UIView+Additions.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 13.05.17.
//
//

import UIKit
import RxSwift
import RxCocoa

extension UIView {

  class var identifier: String {
    return String(describing: self)
  }

  var identifier: String {
    return String(describing: type(of: self))
  }

  class func loadFromNib(_ nibName: String, bundle: Bundle? = Bundle.main) -> UIView? {
    let a = UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: self, options: nil)[0] as? UIView
    return a
  }

  func setupRadius(withBorderWidth borderWidth: CGFloat = 0.0, borderColor: UIColor? = nil,
                   cornerRadius: CGFloat = NumberConstant.defaultCornerRadius) {
    self.layer.masksToBounds = true
    self.layer.cornerRadius = cornerRadius
    self.layer.borderColor = borderColor?.cgColor
    self.layer.borderWidth = borderWidth
  }

  func makeCircule() {
    self.layer.masksToBounds = true
    self.layer.cornerRadius = self.frame.width/2
  }

  func setupMatchParentConstraints() {
    guard self.superview != nil else {
      return
    }
    self.translatesAutoresizingMaskIntoConstraints = false

    let views = ["view": self]
    let verticalFormatString = "V:|[view]|"
    let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: verticalFormatString,
      options:.alignAllTop, metrics: nil, views: views)
    NSLayoutConstraint.activate(verticalConstraints)

    let horizontalFormatString = "H:|[view]|"
    let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: horizontalFormatString,
      options:.alignAllTop, metrics: nil, views: views)
    NSLayoutConstraint.activate(horizontalConstraints)
  }

  func addAndFillWithSubview(_ view: UIView) {
    view.frame = self.bounds
    self.addSubview(view)
    view.setupMatchParentConstraints()
  }

  class var nib: UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
}

extension Reactive where Base: UIView {
  var backgroundColor: UIBindingObserver<Base, UIColor> {
    return UIBindingObserver(UIElement: self.base) { view, backgroundColor in
      view.backgroundColor = backgroundColor
    }
  }
}
