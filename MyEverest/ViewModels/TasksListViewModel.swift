//
//  TasksListViewModel.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 19.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import Foundation
import RxSwift

class TasksListViewModel {
  private(set) var goal: Goal!
  private(set) var goalObservable: Observable<Goal?>!
  private(set) var tasksObsrvable: Observable<[Task]>!
  private(set) var titleObsrvable: Observable<String?>!
  private(set) var colorObsrvable: Observable<UIColor?>!

  init(from goal: Goal) {
    self.goal = goal
    let goalPredicate = NSPredicate(format: "(SELF = %@)", self.goal.objectID)
    self.goalObservable = CoreDataModel.shared.rx.fetchObject(predicate: goalPredicate)
    self.titleObsrvable = goalObservable.map { $0?.name }
    self.colorObsrvable = goalObservable.map { $0?.color?.color() }

    let tasksPredicate = NSPredicate(format: "(goal = %@)", self.goal.objectID)
    self.tasksObsrvable = CoreDataModel.shared.rx.fetchObjects(predicate: tasksPredicate)
  }

  func task(_ task: Task, isChecked checked: Bool) {
    task.isComplete = checked
    task.doneDate = checked ? Date() : nil
    CoreDataModel.shared.saveContext()
  }
}
