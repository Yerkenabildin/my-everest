//
//  UIAlertController+UIImagePickerController.swift
//  GoBiker-V2
//
//  Created by Yerkebulan Abildin on 24.03.18.
//  Copyright © 2018 Nour Helmi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

fileprivate struct RxImagePickerAlertAction: RxAlertActionType {
  typealias Result = UIImagePickerControllerSourceType

  let title: String?
  let style: UIAlertActionStyle
  let result: Result?
}

extension Reactive where Base: UIImagePickerController {
  static func presentImagePicker(viewController: UIViewController) -> Observable<UIImage?> {
    let cameraAction = RxImagePickerAlertAction(title: "GBKLocalized.text_take_photo()",
                                                style: .default,
                                                result: .camera)
    let libAction = RxImagePickerAlertAction(title: "GBKLocalized.text_upload_from_album()",
                                             style: .default,
                                             result: .photoLibrary)
    let cancelAction = RxImagePickerAlertAction(title: "GBKLocalized.button_cancel()",
                                                style: .cancel,
                                                result: nil)
    return UIAlertController.rx.presentAlert(viewController: viewController,
                                             preferredStyle: .actionSheet,
                                             actions: [cameraAction, libAction, cancelAction])
      .unwrap()
      .flatMap { action in
        return UIImagePickerController.rx.createWithParent(viewController) { picker in
          picker.sourceType = action
          picker.allowsEditing = false
        }
      }
      .flatMap {
        $0.rx.didFinishPickingMediaWithInfo
      }
      .take(1)
      .map {
        $0[UIImagePickerControllerOriginalImage] as? UIImage
    }

  }
}
