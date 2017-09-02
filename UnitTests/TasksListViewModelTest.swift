//
//  TasksListViewModelTest.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 19.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import MyEverest

// TODO: - Add Test for Goal
class TasksListViewModelTest: QuickSpec {
  var disposeBag: DisposeBag!
  var tasks: [Task] = []
  var goal: Goal!
  var viewModel: TasksListViewModel!

  private func generateViewModel() -> TasksListViewModel {
    let task = self.generateTask()
    self.goal = self.generateGoal()
    task.goal = self.goal
    CoreDataModel.default.save(goal)
    CoreDataModel.default.save(task)
    let viewModel = TasksListViewModel(from: goal)
    return viewModel
  }

  override func spec() {
    describe("TasksListViewModel") {
      beforeEach {
        self.disposeBag = DisposeBag()
        self.viewModel = self.generateViewModel()
        self.viewModel.tasksObsrvable
          .subscribe(onNext: { value in
            self.tasks = value
          }).addDisposableTo(self.disposeBag)

        self.viewModel.goalObservable
          .subscribe(onNext: { value in
            self.goal = value
          }).addDisposableTo(self.disposeBag)
      }

      describe("Tasks") {
        it("Add new task") {
          let task = self.generateTask()
          CoreDataModel.default.insert(task)
          task.goal = self.goal
          CoreDataModel.default.save(task)
          expect(self.tasks).toEventuallyNot(beEmpty())
          let taskFromDB = self.tasks.first { $0.objectID == task.objectID }
          expect(taskFromDB).toEventuallyNot(beNil())
        }

        it("Delete task") {
          expect(self.tasks).toEventuallyNot(beEmpty())
          let task = self.tasks.first!
          let count = self.tasks.count
          CoreDataModel.default.delete(task)
          expect(self.tasks.count).toEventually(equal(count-1))
          let taskFromDB = self.tasks.first { $0.objectID == task.objectID }
          expect(taskFromDB).to(beNil())
        }

        it("Update task") {
          expect(self.tasks).toEventuallyNot(beEmpty())
          let task = self.tasks.first!
          self.viewModel.task(task, isChecked: true)
          var taskFromDB = self.tasks.first { $0.objectID == task.objectID }
          expect(taskFromDB?.doneDate).toEventually(equal(task.doneDate))

          self.viewModel.task(task, isChecked: false)
          taskFromDB = self.tasks.first { $0.objectID == task.objectID }
          expect(taskFromDB?.doneDate).toEventually(beNil())
        }
      }

      describe("Goal") {
        it("Update") {
          expect(self.goal).toEventuallyNot(beNil())
          self.goal.name = "newName"
          CoreDataModel.default.save(self.goal)
          let goalFromDB: Goal? =  try! self.viewModel.goalObservable.toBlocking().first()
          expect(goalFromDB?.name).toEventually(equal(self.goal.name))
        }
      }
    }
  }
}
