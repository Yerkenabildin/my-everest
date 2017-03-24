//
//  UILabel+Additions.swift
//  Railways
//
//  Created by Yerkebulan Abildin on 08.06.17.
//  Copyright © 2017 Aviata. All rights reserved.
//

import UIKit

extension UILabel {
  func configure(fontSize: CGFloat = NumberConstant.defaultFontSize,
                 textColor: UIColor = ColorConstants.textColor) {
    self.font = FontConstants.regular(fontSize)
    self.textColor = textColor
  }
}
