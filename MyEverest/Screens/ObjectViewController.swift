//
//  ObjectViewController.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 14.05.17.
//
//

import UIKit
import RxSwift
import RxCocoa

class ObjectViewController: BaseViewController {

  @IBOutlet private var navigationBar: UINavigationBar!
  @IBOutlet private var lines: [UIView]!
  @IBOutlet private var icons: [UIImageView]!
  @IBOutlet private(set) var titleTextField: UITextField!
  @IBOutlet private(set) var noteTextView: CommonTextView!
  @IBOutlet private(set) var saveButton: UIBarButtonItem!
  @IBOutlet private(set) var closeButton: UIBarButtonItem!

  override func setup() {
    super.setup()
    self.titleTextField.becomeFirstResponder()
    self.titleTextField.textColor = UIColor.white

    self.closeButton.rx.tap
      .subscribe( onNext: {
        self.dismiss(animated: true, completion: nil)
      }).addDisposableTo(self.disposeBag)
  }

  override func setupTintColor() {
    super.setupTintColor()

    self.tintColor.asObservable()
      .bind(to: self.navigationBar.rx.barTintColor)
      .addDisposableTo(self.disposeBag)

    Observable.just(UIColor.white)
      .bind(to: self.navigationBar.rx.tintColor)
      .addDisposableTo(self.disposeBag)

    self.tintColor.asObservable()
      .subscribe(onNext: { color in
        for line in self.lines {
          line.backgroundColor = color.withAlphaComponent(0.5)
        }
        for icon in self.icons {
          icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
          icon.tintColor = color
        }
      }).addDisposableTo(self.disposeBag)
  }
}
