//
//  TasksListViewModelTest.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 19.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import XCTest
import RxSwift
@testable import MyEverest

class TasksListViewModelTest: XCTestCase {

  var tasksListExpectation: XCTestExpectation!
  let disposeBag = DisposeBag()

  override func setUp() {
    super.setUp()
    setupGoalWithOneTask()
    self.tasksListExpectation = expectation(description: "Callback is successful")
  }

  func testTasks() {
    guard let goal: Goal = CoreDataModel.shared.fetchObjects()?.first else {
      XCTFail()
      return
    }

    TasksListViewModel(from: goal).tasksObsrvable
      .subscribe(onNext: { tasks in
        XCTAssertEqual(tasks.count, 1)
        self.tasksListExpectation.fulfill()
      }).addDisposableTo(self.disposeBag)

    waitForExpectations(timeout: 5.0) {error in
      XCTAssertNil(error)
    }
  }

  func testTitleObservable() {
    let goal = generateGoal()
    let task = generateTask()
    task.goal = goal
    CoreDataModel.shared.saveContext()

    TasksListViewModel(from: goal).titleObsrvable
      .subscribe(onNext: { title in
        XCTAssertEqual(title, goal.name)
        self.tasksListExpectation.fulfill()
      }).addDisposableTo(self.disposeBag)

    waitForExpectations(timeout: 5.0) {error in
      XCTAssertNil(error)
    }
  }

  func testColorObservable() {
    let goal = generateGoal()
    let task = generateTask()
    task.goal = goal
    CoreDataModel.shared.saveContext()

    TasksListViewModel(from: goal).colorObsrvable
      .subscribe(onNext: { color in
        XCTAssertEqual(color, goal.color?.color())
        self.tasksListExpectation.fulfill()
      }).addDisposableTo(self.disposeBag)

    waitForExpectations(timeout: 5.0) {error in
      XCTAssertNil(error)
    }
  }
}
