//
//  File.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 14.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import Quick
@testable import MyEverest

extension QuickSpec {
  
  @discardableResult
  func generateGoal() -> Goal {
    let goal = Goal()
    goal.name = randomString()
    goal.note = randomString()
    goal.color = .blue
    goal.tasks = []
    return goal
  }

  @discardableResult
  func generateTask() -> Task {
    let task = Task()
    task.name = randomString()
    task.note = randomString()
    return task
  }

  func deleteAll() {
    CoreDataModel.default.delete(allObjectOf: Task.self)
    CoreDataModel.default.delete(allObjectOf: Goal.self)
  }

  func setupGoalWithOneTask() {
    let goal = generateGoal()
    let task = generateTask()
    task.goal = goal
    CoreDataModel.default.save(goal)
    CoreDataModel.default.save(task)
  }

  private func randomString() -> String {

    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(10)

    var randomString = ""

    for _ in 0 ..< 10 {
      let rand = arc4random_uniform(len)
      var nextChar = letters.character(at: Int(rand))
      randomString += NSString(characters: &nextChar, length: 1) as String
    }

    return randomString
  }
}
