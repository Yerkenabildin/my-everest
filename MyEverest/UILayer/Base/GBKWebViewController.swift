//
//  GBKWebViewController.swift
//  GoBiker-V2
//
//  Created by Nour Helmi on 08/03/2018.
//  Copyright © 2018 Nour Helmi. All rights reserved.
//

import Foundation
import UIKit

class GBKWebViewController: UIViewController {

  var webview: UIWebView!
  var coordinator: CoordinatorType?

  override func viewDidLoad() {
    super.viewDidLoad()

    // Customize navigation item button
    let btnBack = UIBarButtonItem(image: R.image.btn_back(),
                                  style: UIBarButtonItemStyle.plain,
                                  target: self,
                                  action: #selector(self.goBack(_:)))
    self.navigationItem.leftBarButtonItem = btnBack

    self.webview = UIWebView(frame: self.view.bounds)
    self.view.addSubview(self.webview)
  }

  func configure(withURL url: URL) {
    self.webview.loadRequest(URLRequest(url: url))
  }

  @objc func goBack(_ sender: UIButton) {
    self.navigationController?.dismiss(animated: true, completion: nil)
  }
}
