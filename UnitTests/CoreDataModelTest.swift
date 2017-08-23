//
//  LocalStorageModelTest.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 13.08.17.
//
//

import XCTest
import CoreData
import RxSwift
import RxBlocking
@testable import MyEverest

class CoreDataModelTest: XCTestCase {

  func testSaveGoalWithTask() {
    let goal = generateGoal()
    let task = generateTask()
    goal.tasks = [task]
    CoreDataModel.shared.saveContext()
    guard let goals: [Goal] = CoreDataModel.shared.fetchObjects() else {
      XCTFail()
      return
    }
    let savedGoal = goals.first!
    XCTAssertNotNil(savedGoal)
    XCTAssertEqual(goals.count, 1)
    XCTAssertEqual(goal.name, savedGoal.name)
    XCTAssertEqual(goal.note, savedGoal.note)
    XCTAssertEqual(goal.tasks.count, savedGoal.tasks.count)
    guard let savedTask = savedGoal.tasks.first else {
      XCTFail()
      return
    }
    XCTAssertEqual(task.name, savedTask.name)
    XCTAssertEqual(task.note, savedTask.note)
    XCTAssertEqual(task.doneDate, savedTask.doneDate)
    XCTAssertEqual(task.isComplete, savedTask.isComplete)
  }

  func testRemoveGoal() {
    testSaveGoalWithTask()
    var goals: [Goal] = CoreDataModel.shared.fetchObjects() ?? []
    var tasks: [Task] = CoreDataModel.shared.fetchObjects() ?? []
    XCTAssertEqual(goals.count, 1)
    XCTAssertEqual(tasks.count, 1)
    let goal = goals.first!
    CoreDataModel.shared.delete(goal)
    goals = CoreDataModel.shared.fetchObjects() ?? []
    tasks = CoreDataModel.shared.fetchObjects() ?? []
    XCTAssertEqual(goals.count, 0)
    XCTAssertEqual(tasks.count, 0)
  }

  func testRemoveTask() {
    testSaveGoalWithTask()
    var tasks: [Task] = CoreDataModel.shared.fetchObjects() ?? []
    XCTAssertEqual(tasks.count, 1)
    let task = tasks.first!
    CoreDataModel.shared.delete(task)
    tasks = CoreDataModel.shared.fetchObjects() ?? []
    XCTAssertEqual(tasks.count, 0)
  }

  func testUpdateGoal() {
    testSaveGoalWithTask()
    var goals: [Goal] = CoreDataModel.shared.fetchObjects() ?? []
    let savedGoal = goals.first!
    let newName = "new name"
    savedGoal.name = newName
    CoreDataModel.shared.saveContext()
    goals = CoreDataModel.shared.fetchObjects() ?? []
    let updatedGoal = goals.first!
    XCTAssertEqual(updatedGoal.name, newName)
  }

  func testUpdateTask() {
    testSaveGoalWithTask()
    var goals: [Goal] = CoreDataModel.shared.fetchObjects() ?? []
    let savedGoal = goals.first!
    XCTAssertEqual(savedGoal.tasks.count, 1)
    guard let savedTask = savedGoal.tasks.first else {
      XCTFail()
      return
    }
    let newName = "new name"
    savedTask.name = newName
    CoreDataModel.shared.saveContext()
    goals = CoreDataModel.shared.fetchObjects() ?? []
    let updatedGoal = goals.first!
    XCTAssertEqual(savedGoal.tasks.count, 1)
    guard let updatedTask = updatedGoal.tasks.first else {
      XCTFail()
      return
    }
    XCTAssertEqual(updatedTask.name, newName)
  }

  func testEntityName() {
    let name = String(describing: Goal.self)
    let entity = CoreDataModel.shared.entityForName(name)
    XCTAssertNotNil(entity)
  }

  func testWrongEntityName() {
    let entity = CoreDataModel.shared.entityForName("WrongName")
    XCTAssertNil(entity)
  }

  func testSaveNoChanges() {
    CoreDataModel.shared.saveContext()
    let goals: [Goal] = CoreDataModel.shared.fetchObjects() ?? []
    XCTAssertEqual(goals.count, 0)
  }

  func testSaveChanges() {
    generateGoal()
    CoreDataModel.shared.saveContext()
    let goals: [Goal] = CoreDataModel.shared.fetchObjects() ?? []
    XCTAssertEqual(goals.count, 1)
  }

  func testFetchByID() {
    let goal = generateGoal()
    CoreDataModel.shared.saveContext()
    let savedGoal: Goal? = CoreDataModel.shared.fetchObject(by: goal.objectID)
    XCTAssertNotNil(savedGoal)
    XCTAssertEqual(savedGoal?.name, goal.name)
    XCTAssertEqual(savedGoal?.note, goal.note)
    XCTAssertEqual(savedGoal?.tasks.count, goal.tasks.count)
  }

  func testListObservable() throws {
    var result: [Goal]?
    XCTAssertNil(result)
    let observable: Observable<[Goal]> = CoreDataModel.shared.rx.fetchObjects()
    XCTAssertNoThrow(result = try observable.toBlocking().first())
    XCTAssertEqual(result?.count, 0)
    setupGoalWithOneTask()
    XCTAssertNoThrow(result = try observable.toBlocking().first())
    XCTAssertEqual(result?.count, 1)
  }

  func testObjectObservable() throws {
    var goal: Goal? = generateGoal()
    CoreDataModel.shared.saveContext()
    XCTAssertNotNil(goal)
    let goalPredicate = NSPredicate(format: "(SELF = %@)", goal?.objectID ?? "")
    let observable: Observable<Goal?> = CoreDataModel.shared.rx.fetchObject(predicate: goalPredicate).debug()
    let newName = "new name"
    XCTAssertNotEqual(goal?.name, newName)
    goal?.name = newName
    CoreDataModel.shared.saveContext()
    XCTAssertNoThrow(goal = try observable.toBlocking().first() as? Goal)
    XCTAssertEqual(goal?.name, newName)
  }
}
