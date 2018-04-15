import Foundation

enum InnerError: LocalizedError {
  case wrongType
  case nilValue
  case noImplementation

  var debugDescription: String {
    switch self {
    case .wrongType:
      return "Не правильный формат"
    case .noImplementation:
      return "Нет имплементации"
    case .nilValue:
      return "Value does not exist"
    }
  }

  var localizedDescription: String {
    return self.debugDescription
  }
}

enum MyError: LocalizedError {
  case general(String)

  var debugDescription: String {
    switch self {
    case .general(let description):
      return description
    }
  }

  var localizedDescription: String {
    switch self {
    case .general(let description):
      return description
    }
  }
}

extension Array where Element: Error {
  var localizedDescription: String {
    var text = ""
    for i in 0 ..< self.count {
      let error = self[i]
      if i != self.count-1 {
        text += "\n"
      }
      text += error.localizedDescription
    }
    return text
  }
}
