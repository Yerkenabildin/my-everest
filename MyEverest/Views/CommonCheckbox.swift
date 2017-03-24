//
//  CommonCheckbox.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 10.06.17.
//
//

import UIKit

fileprivate struct Constant {
  static let checkbox = #imageLiteral(resourceName: "checkbox")
  static let checkboxOn = #imageLiteral(resourceName: "checkbox on")
  static let paddingToImage: CGFloat = 10.0
}

class CommonCheckbox: UIButton {
  var didSelected: ((Bool) -> Void)?

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
  }

  convenience init() {
    self.init(frame: CGRect.zero)
  }

  // MARK: - Setup
  private func setup() {
    self.setImage(Constant.checkbox, for: .normal)
    self.setImage(Constant.checkboxOn, for: .selected)
    let spacing = Constant.paddingToImage
    self.addTarget(self, action: #selector(didClick), for: .touchUpInside)
    self.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: spacing)
    self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: spacing, bottom: 0.0, right: 0.0)
  }

  @objc private func didClick() {
    self.isSelected = !self.isSelected
    self.didSelected?(self.isSelected)
  }
}
