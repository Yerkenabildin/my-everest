//
//  AlertManager.swift
//  BucketList
//
//  Created by  on 5/10/17.
//
//

import UIKit
import SCLAlertView

fileprivate struct Constant {
  static let errorTitle = "Error"
  static let successTitle = "Success"
  static let appearance = SCLAlertView.SCLAppearance(
    hideWhenBackgroundViewIsTapped: true
  )
}

class AlertManager: SCLAlertView {
  var responder: SCLAlertViewResponder?

  init(width: CGFloat, showCloseButton: Bool = true) {
    let appearance = SCLAlertView.SCLAppearance(
      kWindowWidth: width,
      showCloseButton: showCloseButton,
      hideWhenBackgroundViewIsTapped: true
    )
    super.init(appearance: appearance)
    for recognizer in self.view.gestureRecognizers! {
      self.view.removeGestureRecognizer(recognizer)
    }
  }

  required init() {
    super.init(appearance: Constant.appearance)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  @discardableResult
  func showError(_ errorMessage: String) -> SCLAlertViewResponder {
    hideKeyboard()
    self.responder = super.showError(Constant.errorTitle, subTitle: errorMessage, animationStyle: .noAnimation)
    return self.responder!
  }

  @discardableResult
  func showEdit(_ title: String) -> SCLAlertViewResponder {
    hideKeyboard()
    self.responder = super.showEdit(title, subTitle: "", animationStyle: .noAnimation)
    return self.responder!
  }

  @discardableResult
  func showSuccess(_ message: String) -> SCLAlertViewResponder {
    hideKeyboard()
    self.responder = super.showSuccess(Constant.successTitle, subTitle: message, animationStyle: .noAnimation)
    return self.responder!
  }

  private func hideKeyboard() {
    UIApplication.topViewController()?.view.endEditing(true)
  }

  func close() {
    self.responder?.close()
  }
}
