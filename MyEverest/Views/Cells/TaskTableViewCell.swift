//
//  TaskTableViewCell.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 20.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import UIKit
import RxSwift

class TaskTableViewCell: UITableViewCell {

  @IBOutlet var checkBox: CommonCheckbox!
  @IBOutlet var titleLabel: UILabel!
  var disposeBag = DisposeBag()

  static var height: CGFloat {
    return 60.0
  }
}
