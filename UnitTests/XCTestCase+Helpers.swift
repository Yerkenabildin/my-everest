//
//  File.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 14.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import XCTest
@testable import MyEverest

extension XCTestCase {

  open override func setUp() {
    deleteAll()
  }

  @discardableResult
  func generateGoal() -> Goal {
    let goal = Goal()
    goal.name = "Frontend"
    goal.note = "Изучить Vue.js, webpack, bootstrap и все что связанно с frontend-ом"
    goal.color = .blue
    goal.tasks = []
    return goal
  }

  @discardableResult
  func generateTask() -> Task {
    let task = Task()
    task.name = "Vue.js components"
    task.note = "Изучить Vue.js component"
    return task
  }

  func deleteAll() {
    CoreDataModel.shared.deleteAllObjects(of: Task.self)
    CoreDataModel.shared.deleteAllObjects(of: Goal.self)
  }

  func setupGoalWithOneTask() {
    let goal = generateGoal()
    let task = generateTask()
    task.goal = goal
    CoreDataModel.shared.saveContext()
  }
}
