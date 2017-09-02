//
//  GoalsListViewModel.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 18.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

class GoalsListViewModel {
  private(set) var goalsObsrvable: Observable<[Goal]>!
  private let dataModel: DataModelProtocol!

  init() {
    self.dataModel = CoreDataModel.default
    self.goalsObsrvable = self.dataModel.rxFetchObjects(predicate: nil)
  }
}
