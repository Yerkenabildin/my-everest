//
//  String+Additions.swift
//  BucketList
//
//  Created by  on 5/15/17.
//
//

import Foundation
import RxSwift

extension String {
  func toDate(withFormate formate: String = "dd.MM.yyyy") -> Date? {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = formate
    return dateFormatterGet.date(from: self)
  }

    func replaceAllChars(with char: String) -> String {
        var result = ""
        for _ in self {
            result += char
        }
        return result
    }
}
