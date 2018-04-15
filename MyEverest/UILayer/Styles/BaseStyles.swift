//
//  BaseStyles.swift
//  GoBiker-V2
//
//  Creatxed by Nour Helmi on 05/03/2018.
//  Copyright © 2018 Nour Helmi. All rights reserved.
//

import Foundation
import UIKit

struct BaseStyles {
  static func rounded<V: UIView>(cornerRadius r: CGFloat = 4) -> UIViewStyle<V> {
    return UIViewStyle<V>(styling: { (view: V) in
      view.layer.masksToBounds = true
      view.clipsToBounds = true
      view.layer.cornerRadius = r
    })
  }

  static func border<V: UIView>(width: CGFloat = 4.0) -> UIViewStyle<V> {
    return UIViewStyle<V>(styling: { (view: V) in
      view.layer.borderColor = UIColor.black.cgColor
      view.layer.borderWidth = width
    })
  }

  static func rounded<V: UIView>(corners: UIRectCorner, cornerRadius: CGFloat = 8.0) -> UIViewStyle<V> {
    return UIViewStyle<V>(styling: { view in
      let rectShape = CAShapeLayer()
      rectShape.bounds = view.frame
      rectShape.position = view.center
      rectShape.path = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
      view.layer.mask = rectShape
      view.layer.masksToBounds = true
    })
  }

  static func circle<V: UIView>() -> UIViewStyle<V> {
    return BaseStyles.rounded().composing(with: { (v) in
      v.layer.cornerRadius = v.frame.size.height / 2
    })
  }

  static let card: UIViewStyle<UIView> = rounded(cornerRadius: 5).composing { view in
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    shadow.styling(view)
  }

  static let shadow: UIViewStyle<UIView> = UIViewStyle { view in
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.25
    view.layer.shadowRadius = 2
    view.layer.masksToBounds = false
  }

  static let background: UIViewStyle<UIView> = UIViewStyle { view in
    view.backgroundColor = UIColor.black
  }

  static let separator: UIViewStyle<UIView> = UIViewStyle { view in
    view.backgroundColor = UIColor.black
  }

  static let tableView: UIViewStyle<UITableView> = UIViewStyle { tableView in
    tableView.separatorStyle = .none
    background.styling(tableView)
  }
}
