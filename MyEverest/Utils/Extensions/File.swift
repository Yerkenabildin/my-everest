//
//  File.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 15.04.18.
//  Copyright © 2018 abild.in. All rights reserved.
//

import Foundation
import Swinject

extension Resolver {
  public func resolveNoNil<Service>(_ serviceType: Service.Type) -> Service {
    guard let item = self.resolve(serviceType) else {
      fatalError(.noImplementation)
    }
    return item
  }
}
