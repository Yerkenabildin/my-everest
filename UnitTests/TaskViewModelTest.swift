//
//  TaskViewModelTest.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 14.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import XCTest
import RxSwift
@testable import MyEverest

class TaskViewModelTest: XCTestCase {
  var viewModel: TaskViewModel!
  let nameSubject = PublishSubject<String?>()
  let noteSubject = PublishSubject<String?>()
  let doneDateSubject = PublishSubject<Date?>()
  let deadlineDateSubject = PublishSubject<Date?>()
  let goalSubject = PublishSubject<Goal?>()
  let triggerSubject = PublishSubject<Void>()
  let disposeBag = DisposeBag()
  var callbackExpectation: XCTestExpectation!
  typealias ErrorBlock = (([MyError]?) -> Void)

  override func setUp() {
    super.setUp()
    self.callbackExpectation = expectation(description: "Callback is successful")
  }

  private func setupViewModel(with task: Task, callback: @escaping ErrorBlock) {
    self.viewModel = TaskViewModel(with: task)
    setupViewModel(callback: callback)
  }

  private func setupViewModel(with goalObservable: Observable<Goal?>, callback: @escaping ErrorBlock) {
    self.viewModel = TaskViewModel(with: goalObservable)
    setupViewModel(callback: callback)
  }

  private func setupViewModel(callback: @escaping ErrorBlock) {
    let nameObservable = self.nameSubject.asObservable()
    let noteObservable = self.noteSubject.asObservable()
    let doneDateObservable = self.doneDateSubject.asObservable()
    let deadlineDateObservable = self.deadlineDateSubject.asObservable()
    let triggerObservable = self.triggerSubject.asObservable()

    let input = (nameObservable: nameObservable, noteObservable: noteObservable,
      doneDateObservable: doneDateObservable, deadlineObservable: deadlineDateObservable)
    self.viewModel.configure(input: input, triggerObservable: triggerObservable) { errors in
      self.callbackExpectation.fulfill()
      callback(errors)
    }
  }

  private func sendParams(name: String?, note: String?, doneDate: Date?, goal: Goal?) {
    self.nameSubject.onNext(name)
    self.noteSubject.onNext(note)
    self.doneDateSubject.onNext(doneDate)
    self.deadlineDateSubject.onNext(nil)
    self.goalSubject.onNext(goal)
    self.triggerSubject.onNext()
  }

  // MARK: - Tests
  func testSaveExample() {
    setupViewModel(with: self.goalSubject.asObservable()) { errors in
      XCTAssertNil(errors)
    }

    let name = "name"
    let note = "note"
    let doneDate = Date()
    let goal = generateGoal()
    sendParams(name: name, note: note, doneDate: doneDate, goal: goal)

    waitForExpectations(timeout: 5.0) { error in
      guard let tasks: [Task] = CoreDataModel.shared.fetchObjects() else {
        XCTFail()
        return
      }
      let savedTask = tasks.first
      XCTAssertNil(error)
      XCTAssertNotNil(savedTask)
      XCTAssertEqual(tasks.count, 1)
      XCTAssertEqual(savedTask?.name, name)
      XCTAssertEqual(savedTask?.note, note)
      XCTAssertEqual(savedTask?.doneDate, doneDate)
      XCTAssertEqual(savedTask?.goal?.name, goal.name)
    }
  }

  func testEditExample() {
    let task = generateTask()
    let goal = generateGoal()
    task.goal = goal
    CoreDataModel.shared.saveContext()
    setupViewModel(with: task) { errors in
      XCTAssertNil(errors)
    }

    let name = "new name"
    let note = "new note"
    sendParams(name: name, note: note, doneDate: nil, goal: nil)

    waitForExpectations(timeout: 5.0) { error in
      guard let tasks: [Task] = CoreDataModel.shared.fetchObjects() else {
        XCTFail()
        return
      }
      let savedTask = tasks.first
      XCTAssertNil(error)
      XCTAssertNotNil(savedTask)
      XCTAssertEqual(tasks.count, 1)
      XCTAssertEqual(savedTask?.name, name)
      XCTAssertEqual(savedTask?.note, note)
      XCTAssertNil(savedTask?.doneDate)
      XCTAssertEqual(savedTask?.goal?.name, goal.name)
    }
  }

  func testInvalidSave() {
    setupViewModel(with: self.goalSubject.asObservable()) { errors in
      XCTAssertNotNil(errors)
    }

    let name = "т"
    let note = "note"
    let doneDate = Date()
    let goal = generateGoal()
    sendParams(name: name, note: note, doneDate: doneDate, goal: goal)

    waitForExpectations(timeout: 5.0) {error in
      guard let tasks: [Task] = CoreDataModel.shared.fetchObjects() else {
        XCTFail()
        return
      }
      XCTAssertNil(error)
      XCTAssertEqual(tasks.count, 0)
    }
  }

  func testSaveWithoutGoal() {
    setupViewModel(with: self.goalSubject.asObservable()) { errors in
      XCTAssertNotNil(errors)
    }

    let name = "тghjk"
    let note = "note"
    let doneDate = Date()
    sendParams(name: name, note: note, doneDate: doneDate, goal: nil)

    waitForExpectations(timeout: 5.0) {error in
      guard let tasks: [Task] = CoreDataModel.shared.fetchObjects() else {
        XCTFail()
        return
      }
      XCTAssertNil(error)
      XCTAssertEqual(tasks.count, 0)
    }
  }

  func testInvalidEditExample() {
    let task = generateTask()
    task.goal = generateGoal()
    CoreDataModel.shared.saveContext()
    setupViewModel(with: task) { errors in
      XCTAssertNotNil(errors)
    }

    let name = "n"
    let note = "new note"
    let doneDate = Date()
    sendParams(name: nil, note: note, doneDate: doneDate, goal: nil)

    waitForExpectations(timeout: 5.0) {error in
      guard let tasks: [Task] = CoreDataModel.shared.fetchObjects() else {
        XCTFail()
        return
      }
      let savedTask = tasks.first
      XCTAssertNil(error)
      XCTAssertNotNil(savedTask)
      XCTAssertEqual(tasks.count, 1)
      XCTAssertNotEqual(savedTask?.name, name)
      XCTAssertNotEqual(savedTask?.note, note)
      XCTAssertNotEqual(savedTask?.doneDate, doneDate)
    }
  }
}
