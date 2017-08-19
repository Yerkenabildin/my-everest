//
//  String+Additions.swift
//  BucketList
//
//  Created by  on 5/15/17.
//
//

import Foundation

extension String {
  func toDate(withFormate formate: String = "dd.MM.yyyy") -> Date? {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = formate
    return dateFormatterGet.date(from: self)
  }
}
