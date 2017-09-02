//
//  GoalViewModel.swift
//  BucketList
//
//  Created by  on 5/10/17.
//
//

import Foundation
import RxSwift

class TaskViewModel {
  private var task: Variable<Task>!
  private(set) var taskObservable: Observable<Task>!
  private(set) var validationObsrvable: Observable<MyError?>!
  lazy var nameObservable = Observable<String?>.of(nil)
  lazy var noteObservable = Observable<String?>.of(nil)
  lazy var goalObservable = Observable<Goal?>.of(nil)
  lazy var dueDateObservable = Observable<Date?>.of(nil)
  lazy var doneDateObservable = Observable<Date?>.of(nil)
  lazy var saveTriggerObservable = Observable<Void>.of()

  init(with task: Task) {

  }

  init(with goalObservable: Observable<Goal?>) {
    self.goalObservable = goalObservable
  }
}
