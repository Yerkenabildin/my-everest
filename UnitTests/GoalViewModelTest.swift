//
//  TaskViewModelTest.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 14.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxBlocking
@testable import MyEverest

class TaskViewModelTest: QuickSpec {

  var viewModel: GoalViewModel!
  var disposeBag: DisposeBag!
  let dataModel: DataModelProtocol = CoreDataModel.default

  override func spec() {
    describe("GoalViewModel") {

      var goal: Goal!

      beforeEach {
        self.deleteAll()
        self.disposeBag = DisposeBag()
        goal = self.generateGoal()
        goal.doneDate = Date()
        goal.dueDate = Date()
        self.dataModel.save(goal)
      }

      it("Information access") {
        self.viewModel = GoalViewModel(with: goal)
        let getedGoal: Goal? = try! self.viewModel.goalObservable.toBlocking().first()
        let name: String? = try! self.viewModel.nameObservable.toBlocking().first() as? String
        let note: String? = try! self.viewModel.noteObservable.toBlocking().first() as? String
        let tasks: [Task]? = try! self.viewModel.tasksObservable.toBlocking().first()
        let color: MaterialColor? = try! self.viewModel.colorObservable.toBlocking().first() as? MaterialColor
        let doneDate: Date? = try! self.viewModel.doneDateObservable.toBlocking().first() as? Date
        let dueDate: Date? = try! self.viewModel.dueDateObservable.toBlocking().first() as? Date
        expect(getedGoal).to(equal(goal))
        expect(name).to(equal(goal.name))
        expect(note).to(equal(goal.note))
        expect(tasks).to(equal(goal.tasks))
        expect(color).to(equal(goal.color))
        expect(doneDate).to(equal(goal.doneDate))
        expect(dueDate).to(equal(goal.dueDate))
      }

      it("Save") {
        self.viewModel = GoalViewModel()
        let name = "name"
        let note = "note"
        let color = MaterialColor.blue
        let tasks: [Task] = []
        let doneDate = Date()
        let dueDate = Date()
        self.viewModel.nameSubject.onNext(name)
        self.viewModel.noteSubject.onNext(note)
        self.viewModel.colorSubject.onNext(color)
        self.viewModel.tasksSubject.onNext(tasks)
        self.viewModel.doneDateSubject.onNext(doneDate)
        self.viewModel.dueDateSubject.onNext(dueDate)
        self.viewModel.saveTriggerSubject.onNext()
        let goal: Goal? = try! self.viewModel.goalObservable.toBlocking().first()
        expect(name).to(equal(goal?.name))
        expect(note).to(equal(goal?.note))
        expect(tasks).to(equal(goal?.tasks))
        expect(color).to(equal(goal?.color))
        expect(doneDate).to(equal(goal?.doneDate))
        expect(dueDate).to(equal(goal?.dueDate))
      }

      it("Edit") {
        self.viewModel = GoalViewModel(with: goal)
        let newName = "name"
        let newNote = "note"
        let newColor = MaterialColor.blue
        let newTasks: [Task] = []
        let newDoneDate = Date()
        let newDueDate = Date()
        self.viewModel.nameSubject.onNext(newName)
        self.viewModel.noteSubject.onNext(newNote)
        self.viewModel.colorSubject.onNext(newColor)
        self.viewModel.tasksSubject.onNext(newTasks)
        self.viewModel.doneDateSubject.onNext(newDoneDate)
        self.viewModel.dueDateSubject.onNext(newDueDate)
        self.viewModel.saveTriggerSubject.onNext()
        let name: String? = try! self.viewModel.nameObservable.toBlocking().first() as? String
        let note: String? = try! self.viewModel.noteObservable.toBlocking().first() as? String
        let tasks: [Task]? = try! self.viewModel.tasksObservable.toBlocking().first()
        let color: MaterialColor? = try! self.viewModel.colorObservable.toBlocking().first() as? MaterialColor
        let doneDate: Date? = try! self.viewModel.doneDateObservable.toBlocking().first() as? Date
        let dueDate: Date? = try! self.viewModel.dueDateObservable.toBlocking().first() as? Date
        expect(newName).to(equal(name))
        expect(newNote).to(equal(note))
        expect(newTasks).to(equal(tasks))
        expect(newColor).to(equal(color))
        expect(newDoneDate).to(equal(doneDate))
        expect(newDueDate).to(equal(dueDate))
      }
    }
  }
}
