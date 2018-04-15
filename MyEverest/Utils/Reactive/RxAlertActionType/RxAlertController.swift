//
//  RxAlertController.swift
//  GoBiker-V2
//
//  Created by Yerkebulan Abildin on 24.03.18.
//  Copyright © 2018 Nour Helmi. All rights reserved.
//

import Foundation
import RxSwift

protocol RxAlertActionType {
    associatedtype Result

    var title: String? { get }
    var style: UIAlertActionStyle { get }
    var result: Result? { get }
}

struct RxAlertAction<R>: RxAlertActionType {
    typealias Result = R

    let title: String?
    let style: UIAlertActionStyle
    let result: R?
}

extension Reactive where Base: UIAlertController {
    static func presentAlert<Action: RxAlertActionType, Result>(viewController: UIViewController,
                                                                title: String? = nil,
                                                                message: String? = nil,
                                                                preferredStyle: UIAlertControllerStyle = .alert,
                                                                animated: Bool = true,
                                                                actions: [Action]) -> Observable<Result?>
                                                                where Action.Result == Result {

        return Observable.create { observer -> Disposable in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
            actions.map { rxAction in
                UIAlertAction(title: rxAction.title, style: rxAction.style, handler: { _ in
                    observer.onNext(rxAction.result)
                    observer.onCompleted()
                })
                }
                .forEach(alertController.addAction)

            viewController.present(alertController, animated: animated, completion: nil)

            return Disposables.create {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
}
