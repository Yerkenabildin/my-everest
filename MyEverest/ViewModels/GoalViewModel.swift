//
//  NewGroupViewModel.swift
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

class GoalViewModel {

  private(set) var colorTitle = Variable<String?>(nil)
  private(set) var goal: Goal?
  private(set) var validationObserver: Observable<Bool>!
  typealias ErrorBlock = (([MyError]?) -> Void)
  private let disposeBag = DisposeBag()

  init(with goal: Goal? = nil) {
    self.goal = goal
  }

  func configure(input:( nameObservable: Observable<String?>, noteObservable: Observable<String?>,
    colorObservable: Observable<MaterialColor?>), triggerObservable: Observable<Void>,
    callback: @escaping ErrorBlock) {

    let goalObservable = Observable.combineLatest(input.nameObservable, input.noteObservable,
      input.colorObservable) { name, note, color in
        return (name: name, note: note, color: color)
      }

    self.validationObserver = input.nameObservable
      .map {
        $0?.characters.count ?? 0 > 1
      }

    let validationErrors = self.validationObserver
      .map {
        $0 ? nil : [MyError.general(Constant.invalidNameText)]
    }

    triggerObservable.withLatestFrom(validationErrors)
      .withLatestFrom(goalObservable) { errors, params -> ([MyError]?, Goal?) in
        guard errors == nil else {
          return (errors, nil)
        }
        let goal = self.goal ?? Goal()
        goal.name = params.name
        goal.note = params.note
        goal.color = params.color
        return (nil, goal)
      }.subscribe(onNext: { error, _ in
        CoreDataModel.shared.saveContext()
        callback(error)
      }).addDisposableTo(self.disposeBag)
  }
}
