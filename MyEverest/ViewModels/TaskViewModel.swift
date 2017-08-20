//
//  GoalViewModel.swift
//  BucketList
//
//  Created by  on 5/10/17.
//
//

import Foundation
import RxSwift

fileprivate struct Constant {
  static let invalidNameText = "name can't be less then 2 characters"
}

class TaskViewModel {

  typealias ErrorBlock = (([MyError]?) -> Void)

  private(set) var task: Task?
  private(set) var validationObsrvable: Observable<Bool>!
  private(set) var colorObsrvable: Observable<UIColor?>!
  private var goalObservable: Observable<Goal?>!
  private let disposeBag = DisposeBag()

  init(with task: Task) {
    self.task = task
    self.goalObservable = Observable.of(task.goal)
  }

  init(with goalObservable: Observable<Goal?>) {
    self.goalObservable = goalObservable
    self.colorObsrvable = self.goalObservable.map { $0?.color?.color() }
  }

  func configure(input:( nameObservable: Observable<String?>, noteObservable: Observable<String?>,
    doneDateObservable: Observable<Date?>, deadlineObservable: Observable<Date?>), triggerObservable: Observable<Void>,
    callback: @escaping ErrorBlock) {
    let taskObservable = Observable.combineLatest(input.nameObservable, input.noteObservable, input.doneDateObservable,
      input.deadlineObservable, self.goalObservable) { name, note, doneDate, deadlineDate, goal in
        return (name: name, note: note, doneDate: doneDate, deadlineDate: deadlineDate, goal: goal)
      }

    self.validationObsrvable = input.nameObservable
      .map {
        $0?.characters.count ?? 0 > 1
      }

    let validationErrors = self.validationObsrvable
      .map {
        $0 ? nil : [MyError.general(Constant.invalidNameText)]
      }

    triggerObservable.withLatestFrom(validationErrors)
      .withLatestFrom(taskObservable) { errors, params -> ([MyError]?, Task?) in
        guard errors == nil else {
          return (errors, nil)
        }
        guard params.goal != nil else {
          unexpectedError(MyError.nilValue)
          return ([MyError.nilValue], nil)
        }
        let task = self.task ?? Task()
        task.name = params.name
        task.note = params.note
        task.goal = params.goal
        task.dueDate = params.deadlineDate
        task.doneDate = params.doneDate
        task.isComplete = (params.doneDate != nil)
        return (nil, task)
      }.subscribe(onNext: { error, _ in
        CoreDataModel.shared.saveContext()
        callback(error)
      }).addDisposableTo(self.disposeBag)
  }
}
