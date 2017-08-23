//
//  TasksListViewModelTest.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 19.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
@testable import MyEverest

class TasksListViewModelTest: XCTestCase {

  let disposeBag = DisposeBag()

  func testTasks() {
    var result: [Task]?
    XCTAssertNil(result)
    let goal = generateGoal()
    let task = generateTask()
    task.goal = goal
    CoreDataModel.shared.saveContext()
    let observable = TasksListViewModel(from: goal).tasksObsrvable
    XCTAssertNoThrow(result = try observable?.toBlocking().first())
    XCTAssertEqual(result?.count, 1)
    setupGoalWithOneTask()
    XCTAssertNoThrow(result = try observable?.toBlocking().first())
    XCTAssertEqual(result?.count, 1)
    let nTask = generateTask()
    goal.tasks.append(nTask)
    CoreDataModel.shared.saveContext()
    XCTAssertNoThrow(result = try observable?.toBlocking().first())
    XCTAssertEqual(result?.count, 2)
  }

  func testTitleObservable() {
    var result: String?
    XCTAssertNil(result)
    let goal = generateGoal()
    CoreDataModel.shared.saveContext()
    let observable = TasksListViewModel(from: goal).titleObsrvable
    XCTAssertNoThrow(result = try observable?.toBlocking().first() ?? "")
    XCTAssertNotNil(result)
    let newName = "new name"
    goal.name = newName
    CoreDataModel.shared.saveContext()
    XCTAssertNoThrow(result = try observable?.toBlocking().first() ?? "")
    XCTAssertEqual(newName, result)
  }

  func testColorObservable() {
    var result: UIColor?
    XCTAssertNil(result)
    let goal = generateGoal()
    CoreDataModel.shared.saveContext()
    let observable = TasksListViewModel(from: goal).colorObsrvable
    XCTAssertNoThrow(result = try observable?.toBlocking().first() ?? .black)
    XCTAssertNotNil(result)
    let newColor = MaterialColor.cyan
    goal.color = newColor
    CoreDataModel.shared.saveContext()
    XCTAssertNoThrow(result = try observable?.toBlocking().first() ?? .black)
    XCTAssertEqual(newColor.color(), result)
  }

  func testTaskComplete() {
    let goal = generateGoal()
    let task = generateTask()
    task.goal = goal
    CoreDataModel.shared.saveContext()
    let predicate = NSPredicate(format: "(SELF = %@)", task.objectID)
    let observable: Observable<Task?> = CoreDataModel.shared.rx.fetchObject(predicate: predicate).debug()

    var result: Task?
    XCTAssertNil(result)
    XCTAssertNoThrow(result = try observable.toBlocking().first() as? Task)
    XCTAssertFalse(result?.isComplete ?? true)
    XCTAssertNil(result?.doneDate)
    TasksListViewModel(from: goal).task(result!, isChecked: true)
    XCTAssertNoThrow(result = try observable.toBlocking().first() as? Task)
    XCTAssertTrue(result?.isComplete ?? false)
    XCTAssertNotNil(result?.doneDate)
  }
}
