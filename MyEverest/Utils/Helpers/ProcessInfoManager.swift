//
//  ProcessInfoManager.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 14.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import Foundation

fileprivate struct ConstantKeys {
  static let emptyDatabase = "-EmptyDatabase"
}

class ProcessInfoManager {
  class var isDatabaseEmpty: Bool {
    return ProcessInfo.processInfo.arguments.contains(ConstantKeys.emptyDatabase)
  }
}
