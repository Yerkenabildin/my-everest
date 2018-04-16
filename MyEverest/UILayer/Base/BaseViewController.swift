//
//  BaseViewController.swift
//  GoBiker-V2
//
//  Created by Nour Helmi on 19/02/2018.
//  Copyright © 2018 Nour Helmi. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

  init() {
    super.init(nibName: type(of: self).defaultNib, bundle: nil)
    Log.initOf(self)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) not implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    self.bindViewModel()
    // hide the back button text
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.bindStyles()
  }

  func setupUI() {

  }

  func bindViewModel() {

  }

  func bindStyles() {

  }

  deinit {
    Log.deinitOf(self)
  }
}
