//
//  BaseViewModel.swift
//  GoBiker-V2
//
//  Created by yerke on 21/03/2018.
//  Copyright © 2018 Nour Helmi. All rights reserved.
//

import Foundation

class BaseViewModel: ViewModelType {

  init() {
    Log.initOf(self)
  }

  deinit {
    Log.deinitOf(self)
  }
}
