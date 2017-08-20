//
//  TasksListViewModel.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 19.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

class TasksListViewModel {
  private var tasksSubject = BehaviorSubject<[Task]>(value: [])
  private(set) var goal: Goal!
  private(set) var goalObservable: Observable<Goal?>!
  private(set) var tasksObsrvable: Observable<[Task]>!
  private(set) var titleObsrvable: Observable<String?>!
  private(set) var colorObsrvable: Observable<UIColor?>!

  init(from goal: Goal) {
    self.goal = goal
    self.goalObservable = Observable.of(goal)
    self.titleObsrvable = goalObservable.map { $0?.name }
    self.colorObsrvable = goalObservable.map { $0?.color?.color() }
    self.tasksObsrvable = self.tasksSubject.asObservable()
    updateGoals()
    setupNotifications()
  }

  func task(_ task: Task, isChecked checked: Bool) {
    task.isComplete = checked
    task.doneDate = checked ? Date() : nil
    CoreDataModel.shared.saveContext()
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
    self.goal = CoreDataModel.shared.fetchObject(by: self.goal.objectID)
    self.tasksSubject.onNext(self.goal.tasks)
  }
}
