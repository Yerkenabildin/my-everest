//
//  MaterialColore.swift
//  BucketList
//
//  Created by  on 5/8/17.
//
//

import UIKit

enum MaterialColor: Int {
  case red
  case pink
  case orange
  case deepOrange
  case purple
  case deepPurple
  case indigo
  case blue
  case lightBlue
  case cyan
  case teal
  case green
  case lightGreen
  case lime
  case brown
  case blueGrey

  func color() -> UIColor {
    return UIColor.colorWithHexaCode(self.code())
  }

  func name() -> String {
      return MaterialColor.names[self.rawValue]
  }

  func code() -> String {
    return MaterialColor.codes[self.rawValue]
  }

  static func instant(with color: UIColor?) -> MaterialColor? {
    guard let color = color else {
      return nil
    }
    for i in 0 ..< MaterialColor.blueGrey.rawValue + 1 {
      if color == UIColor.colorWithHexaCode(MaterialColor.codes[i]) {
        return MaterialColor(rawValue: i)
      }
    }
    return nil
  }

  static var names: [String] {
    return ["Red", "Pink", "Orange", "Deep Orange",
            "Purple", "Deep Purple", "Indigo", "Blue",
            "Light Blue", "Cyan", "Teal", "Green",
            "Light Green", "Lime", "Brown", "Blue Grey"]
  }

  static var codes: [String] {
    return ["#F44336", "#E91E63", "#FF9800", "#FF5722",
            "#9C27B0", "#673AB7", "#3F51B5", "#2196F3",
            "#039BE5", "#006064", "#009688", "#43A047",
            "#689F38", "#827717", "#795548", "#607D8B"]
  }

  static var allColors: [UIColor] {
    return MaterialColor.codes.reduce([UIColor](), { colors, code in
      var colorsMutable = colors
      colorsMutable.append(UIColor.colorWithHexaCode(code))
      return colorsMutable
    })
  }
}
