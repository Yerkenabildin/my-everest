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
  case localStorageFail
  case nilValue

  var debugDescription: String {
    switch self {
    case .general(let description):
      return description
    case .localStorageFail:
      return "There was an error creating or loading the application's saved data."
    case .nilValue:
      return "Value does not exist"
    }
  }

  var localizedDescription: String {
    switch self {
    case .general(let description):
      return description
    case .localStorageFail:
      return "There was an error creating or loading the application's saved data."
    case .nilValue:
      return "Value does not exist"
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
