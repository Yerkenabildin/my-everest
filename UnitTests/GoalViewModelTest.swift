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

class GoalViewModelTest: XCTestCase {

  var viewModel: GoalViewModel!
  let nameSubject = PublishSubject<String?>()
  let noteSubject = PublishSubject<String?>()
  let colorSubject = PublishSubject<MaterialColor?>()
  let triggerSubject = PublishSubject<Void>()
  let disposeBag = DisposeBag()
  var callbackExpectation: XCTestExpectation!
  typealias ErrorBlock = (([MyError]?) -> Void)

  override func setUp() {
    super.setUp()
    self.callbackExpectation = expectation(description: "Callback is successful")
  }

  private func setupViewModel(with goal: Goal? = nil, callback: @escaping ErrorBlock) {
    self.viewModel = GoalViewModel(with: goal)

    let nameObservable = self.nameSubject.asObservable()
    let noteObservable = self.noteSubject.asObservable()
    let colorObservable = self.colorSubject.asObservable()
    let triggerObservable = self.triggerSubject.asObservable()

    let input = ( nameObservable: nameObservable, noteObservable: noteObservable, colorObservable: colorObservable)
    self.viewModel.configure(input: input, triggerObservable: triggerObservable) { errors in
      callback(errors)
      self.callbackExpectation.fulfill()
    }
  }

  private func sendParams(name: String?, note: String?, color: MaterialColor?) {
    self.nameSubject.onNext(name)
    self.noteSubject.onNext(note)
    self.colorSubject.onNext(color)
    self.triggerSubject.onNext()
  }

  // MARK: - Tests
  func testSaveExample() {
    setupViewModel { errors in
      XCTAssertNil(errors)
    }

    let name = "name"
    let note = "note"
    let color = MaterialColor.blue
    sendParams(name: name, note: note, color: color)

    waitForExpectations(timeout: 5.0) {error in
      guard let goals: [Goal] = CoreDataModel.shared.fetchObjects() else {
        XCTFail()
        return
      }
      let savedGoal = goals.first
      XCTAssertNil(error)
      XCTAssertNotNil(savedGoal)
      XCTAssertEqual(goals.count, 1)
      XCTAssertEqual(savedGoal?.name, name)
      XCTAssertEqual(savedGoal?.note, note)
      XCTAssertEqual(savedGoal?.color, color)
      XCTAssertEqual(savedGoal?.tasks.count, 0)
    }
  }

  func testEditExample() {
    let goal = generateGoal()
    CoreDataModel.shared.saveContext()
    setupViewModel(with: goal) { error in
      XCTAssertNil(error)
    }

    let name = "new name"
    let note = "new note"
    let color = MaterialColor.red
    sendParams(name: name, note: note, color: color)

    waitForExpectations(timeout: 5.0) {error in
      guard let goals: [Goal] = CoreDataModel.shared.fetchObjects() else {
        XCTFail()
        return
      }
      let savedGoal = goals.first
      XCTAssertNil(error)
      XCTAssertNotNil(savedGoal)
      XCTAssertEqual(goals.count, 1)
      XCTAssertEqual(savedGoal?.name, name)
      XCTAssertEqual(savedGoal?.note, note)
      XCTAssertEqual(savedGoal?.color, color)
      XCTAssertEqual(savedGoal?.tasks.count, 0)
    }
  }

  func testInvalidSave() {
    setupViewModel { errors in
      XCTAssertNotNil(errors)
    }

    sendParams(name: nil, note: nil, color: nil)

    waitForExpectations(timeout: 5.0) {error in
      guard let goals: [Goal] = CoreDataModel.shared.fetchObjects() else {
        XCTFail()
        return
      }
      XCTAssertNil(error)
      XCTAssertEqual(goals.count, 0)
    }
  }

  func testInvalidEditExample() {
    let goal = generateGoal()
    CoreDataModel.shared.saveContext()
    setupViewModel(with: goal) { errors in
      XCTAssertNotNil(errors)
    }

    let name = "n"
    let note = "new note"
    let color = MaterialColor.red
    sendParams(name: name, note: note, color: color)

    waitForExpectations(timeout: 5.0) {error in
      guard let goals: [Goal] = CoreDataModel.shared.fetchObjects() else {
        XCTFail()
        return
      }
      let savedGoal = goals.first
      XCTAssertNil(error)
      XCTAssertNotNil(savedGoal)
      XCTAssertEqual(goals.count, 1)
      XCTAssertNotEqual(savedGoal?.name, name)
      XCTAssertNotEqual(savedGoal?.note, note)
      XCTAssertNotEqual(savedGoal?.color, color)
      XCTAssertEqual(savedGoal?.tasks.count, 0)
    }
  }
}
