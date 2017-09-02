//
//  MyError.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 11.06.17.
//
//

import Foundation

enum MyError: Error {
  case general(String)
  case wrongType
  case localStorageFail
  case nilValue
  case noImplementation

  var debugDescription: String {
    switch self {
    case .general(let description):
      return description
    case .localStorageFail:
      return "There was an error creating or loading the application's saved data."
    case .wrongType:
      return "Не правильный формат"
    case .noImplementation:
      return "Нет имплементации"
    case .nilValue:
      return "Value does not exist"
    }
  }

  var localizedDescription: String {
    switch self {
    case .general(let description):
      return description
    case .localStorageFail, .wrongType:
      return "There was an error creating or loading the application's saved data."
    default:
      return "Please try again"

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
