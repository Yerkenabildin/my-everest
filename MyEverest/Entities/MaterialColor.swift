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
    return UIColor.hex(self.code())
  }

  func name() -> String {
      return MaterialColor.names[self.rawValue]
  }

  func code() -> UInt32 {
    return MaterialColor.codes[self.rawValue]
  }

  static func instant(with color: UIColor?) -> MaterialColor? {
    guard let color = color else {
      return nil
    }
    for i in 0 ..< MaterialColor.blueGrey.rawValue + 1 {
      if color == UIColor.hex(MaterialColor.codes[i]) {
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

  static var codes: [UInt32] {
    return [0xF44336, 0xE91E63, 0xFF9800, 0xFF5722,
            0x9C27B0, 0x673AB7, 0x3F51B5, 0x2196F3,
            0x39BE5, 0x6064, 0x9688, 0x43A047,
            0x689F38, 0x827717, 0x795548, 0x607D8B]
  }

  static var allColors: [UIColor] {
    return MaterialColor.codes.reduce([UIColor](), { colors, code in
      var colorsMutable = colors
      colorsMutable.append(UIColor.hex(code))
      return colorsMutable
    })
  }
}
