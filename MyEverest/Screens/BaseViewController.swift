//
//  BaseViewController.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 14.05.17.
//
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {

  private(set) var tintColor: Variable<UIColor> = Variable(ColorConstants.tintColor)
  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.view.endEditing(true)
  }

  func setup() {
    setupTexts()
    setupTintColor()
  }

  func setupTexts() { }

  func setupTintColor() {
    if let navigationBar = self.navigationController?.navigationBar {
      self.tintColor.asObservable()
        .bind(to: navigationBar.rx.barTintColor)
        .addDisposableTo(self.disposeBag)

      Observable.just(UIColor.white)
        .subscribe(onNext: { color in
          navigationBar.tintColor = color
          navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: color]
        }).addDisposableTo(self.disposeBag)
    }
  }
}
