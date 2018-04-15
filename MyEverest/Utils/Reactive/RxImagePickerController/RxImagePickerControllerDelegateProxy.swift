//
//  RxImagePickerControllerDelegateProxy.swift
//  GoBiker-V2
//
//  Created by yerke on 23/03/2018.
//  Copyright © 2018 Nour Helmi. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

open class RxImagePickerDelegateProxy: RxNavigationControllerDelegateProxy, UIImagePickerControllerDelegate {
    public init(imagePicker: UIImagePickerController) {
        super.init(navigationController: imagePicker)
    }
}
