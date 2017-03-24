//
//  ColorSelectView.swift
//  BucketList
//
//  Created by  on 5/8/17.
//
//

import UIKit
import IGColorPicker

fileprivate struct Constant {
  static let width: CGFloat = 270.0
  static let height: CGFloat = 260.0
  static let margin: CGFloat = 8.0
}

class CommonColorPickerView: UIControl {

  fileprivate var colorPickerView: ColorPickerView!
  var colors: [UIColor]? {
    didSet {
      guard let colors = self.colors else {
        return
      }
      self.colorPickerView.colors = colors
    }
  }
  var selectedColor: UIColor? {
    didSet {
      self.sendActions(for: .valueChanged)
    }
  }
  var preselectedIndex: Int? {
    didSet {
      self.colorPickerView.preselectedIndex = self.preselectedIndex
      guard let preselectedIndex = self.preselectedIndex,
        let colors = self.colors,
        colors.count > preselectedIndex else {
          return
      }
      self.selectedColor = colors[preselectedIndex]
    }
  }

  convenience init() {
    let frame = CGRect(x: 0.0, y: 0.0, width: Constant.width, height: Constant.height)
    self.init(frame: frame)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  private func commonInit() {
    let frame = CGRect(x: 0.0, y: 0.0, width: Constant.width, height: Constant.height)
    self.colorPickerView = ColorPickerView(frame: frame)
    self.colorPickerView.isSelectedColorTappable = false
    self.colorPickerView.layoutDelegate = self
    self.colorPickerView.delegate = self
    self.addSubview(colorPickerView)
  }
}

extension CommonColorPickerView: ColorPickerViewDelegate {
  func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
    guard let color = self.colors?[indexPath.row] else {
      return
    }
    self.selectedColor = color
  }
}

extension CommonColorPickerView: ColorPickerViewDelegateFlowLayout {
  func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Constant.margin
  }
}
