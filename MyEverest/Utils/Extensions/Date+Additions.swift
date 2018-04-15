//
//  Date+Additions.swift
//  BucketList
//
//  Created by  on 5/15/17.
//
//

import Foundation

extension Date {
  func toString(withFormate formate: String = "dd.MM.yyyy") -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = formate
    return dateFormatterGet.string(from: self)
  }
}
