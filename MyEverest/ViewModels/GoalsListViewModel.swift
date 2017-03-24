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
  private var goalsSubject = BehaviorSubject<[Goal]>(value: [])
  private(set) var goalsObsrvable: Observable<[Goal]>!

  init() {
    self.goalsObsrvable = self.goalsSubject.asObservable()
    setupNotifications()
    updateGoals()
  }

  private func setupNotifications() {
    NotificationCenter
      .default
      .addObserver(self, selector: #selector(contextSaved),
                   name: .NSManagedObjectContextDidSave,
                   object: CoreDataModel.shared.managedObjectContext)
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  @objc private func contextSaved() {
    updateGoals()
  }

  private func updateGoals() {
    if let goals: [Goal] = CoreDataModel.shared.fetchObjects() {
      self.goalsSubject.onNext(goals)
    }
  }
}
