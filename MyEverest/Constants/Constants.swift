//
//  ColorConstants.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 13.05.17.
//
//

import UIKit

struct StringConstants {
  static let mainStoryboardName = "Main"
}

struct NumberConstant {
  static let defaultFontSize: CGFloat = 17.0
  static let defaultCornerRadius: CGFloat = 5.0
}

struct ColorConstants {
  static let tintColor =  UIColor.colorWithHexaCode("009688")
  static let textColor = UIColor.black
  static let placeholderColor = UIColor.colorWithHexaCode("8A8686")
}

struct FontConstants {
  static func regular(_ size: CGFloat = NumberConstant.defaultFontSize) -> UIFont {
    return UIFont(name: "HelveticaNeue", size: size)!
  }
}
