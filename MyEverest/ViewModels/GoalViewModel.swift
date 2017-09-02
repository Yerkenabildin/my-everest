//
//  NewGroupViewModel.swift
//  BucketList
//
//  Created by  on 5/10/17.
//
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt

enum GoalError: Error {
  case nameLengthLess

  var localizedDescription: String {
    switch self {
    case .nameLengthLess:
      return "Name can't be less then 2 characters"
    }
  }
}

class GoalViewModel {
  private var disposeBag = DisposeBag()
  private var goalVariable: Variable<Goal>!
  private(set) var goalObservable: Observable<Goal>!
  private(set) var compliteObsrvable: Observable<Error?>!
  private(set) var nameObservable: Observable<String?>
  private(set) var noteObservable: Observable<String?>
  private(set) var tasksObservable: Observable<[Task]>
  private(set) var colorObservable: Observable<MaterialColor?>
  private(set) var doneDateObservable: Observable<Date?>
  private(set) var dueDateObservable: Observable<Date?>
  private(set) var nameSubject = BehaviorSubject<String?>(value: nil)
  private(set) var noteSubject = BehaviorSubject<String?>(value: nil)
  private(set) var tasksSubject = BehaviorSubject<[Task]?>(value: nil)
  private(set) var colorSubject = BehaviorSubject<MaterialColor?>(value: nil)
  private(set) var doneDateSubject = BehaviorSubject<Date?>(value: nil)
  private(set) var dueDateSubject = BehaviorSubject<Date?>(value: nil)
  private(set) var saveTriggerSubject = PublishSubject<Void>()

  init(with goal: Goal? = nil) {
    let goal = goal ?? Goal()
    self.goalVariable = Variable(goal)
    self.goalObservable = self.goalVariable.asObservable()
    self.nameObservable = self.goalObservable.map { $0.name }
    self.noteObservable = self.goalObservable.map { $0.note }
    self.tasksObservable = self.goalObservable.map { $0.tasks }
    self.colorObservable = self.goalObservable.map { $0.color }
    self.doneDateObservable = self.goalObservable.map { $0.doneDate }
    self.dueDateObservable = self.goalObservable.map { $0.dueDate }
    self.compliteObsrvable = self.saveTriggerSubject
      .withLatestFrom(self.goalObservable).map {
        $0.name?.characters.count ?? 0 < 2 ? GoalError.nameLengthLess : nil
    }
    setupSubscriptions()
  }

  private func setupSubscriptions() {
    Observable.combineLatest(self.nameSubject, self.noteSubject,
                             self.tasksSubject, self.colorSubject,
                             self.doneDateSubject, self.dueDateSubject) {
        return (name: $0, note: $1, tasks: $2, color: $3, doneDate: $4, dueDate: $5)
      }.skip(1)
      .withLatestFrom(self.goalObservable) { ($0, $1) }
      .subscribe(onNext: { params, goal in
        goal.name = params.name
        goal.note = params.note
        goal.tasks = params.tasks ?? []
        goal.color = params.color
        goal.doneDate = params.doneDate
        goal.dueDate = params.dueDate
      }).addDisposableTo(self.disposeBag)

    self.saveTriggerSubject
      .withLatestFrom(self.goalObservable)
      .subscribe(onNext: { goal in
        CoreDataModel.default.save(goal)
      }).addDisposableTo(self.disposeBag)
  }
}
