//
//  BaseViewController.swift
//  GoBiker-V2
//
//  Created by Nour Helmi on 19/02/2018.
//  Copyright © 2018 Nour Helmi. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, HasDisposeBag {

  private let viewModel: ViewModelType
  init(viewModel: ViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: type(of: self).defaultNib, bundle: nil)
    Log.initOf(self)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) not implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindViewModel()
    self.viewModel.bindActivityIndicator()
    self.viewModel.bindErrorTracker()
    setupUIElements()
    // hide the back button text
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.bindStyles()
  }

  func setupUIElements() {

  }

  func bindViewModel() {

  }

  func bindStyles() {

  }

  deinit {
    Log.deinitOf(self)
  }
}
