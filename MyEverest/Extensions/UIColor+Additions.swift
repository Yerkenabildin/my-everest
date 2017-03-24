//
//  ColorExtension.swift
//  MainBalance
//
//  Created by Quoc Nguyen on 9/13/16.
//  Copyright © 2016 Quoc Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  class func colorWithHexaCode(_ hexCode: String) -> UIColor {
    return UIColor.colorWithHexaCode(hexCode, alpha: 1.0)
  }

  class func colorWithHexaCode(_ hexCode: String, alpha: CGFloat) -> UIColor {
    var hex = hexCode
    if hex.hasPrefix("#") {
      let index = hex.index(hex.startIndex, offsetBy: 1)
      hex = hex.substring(from: index)
    }
    guard hex.characters.count == 6 else {
      return UIColor.gray
    }
    var rgbValue: UInt32 = 0
    Scanner(string: hex).scanHexInt32(&rgbValue)
    let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
    let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
  }

  static func == (l: UIColor, r: UIColor) -> Bool {
    var r1: CGFloat = 0
    var g1: CGFloat = 0
    var b1: CGFloat = 0
    var a1: CGFloat = 0
    l.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
    var r2: CGFloat = 0
    var g2: CGFloat = 0
    var b2: CGFloat = 0
    var a2: CGFloat = 0
    r.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
    return r1 == r2 && g1 == g2 && b1 == b2 && a1 == a2
  }
}
