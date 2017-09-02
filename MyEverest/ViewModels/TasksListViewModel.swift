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
  private(set) var goalObservable: Observable<Goal>!
  private(set) var tasksObsrvable: Observable<[Task]>!
  private let dataModel: DataModelProtocol!

  init(from goal: Goal) {
    self.dataModel = CoreDataModel.default
    self.goal = goal
    self.goalObservable = self.dataModel.rxFetch(object: self.goal).unwrap()
    let tasksPredicate = NSPredicate(format: "(goal = %@)", self.goal.objectID)
    self.tasksObsrvable = self.dataModel.rxFetchObjects(predicate: tasksPredicate)
  }

  func task(_ task: Task, isChecked checked: Bool) {
    task.isComplete = checked
    task.doneDate = checked ? Date() : nil
    self.dataModel.save(task)
  }
}
