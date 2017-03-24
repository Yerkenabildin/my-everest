//
//  DateFormateTest.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 16.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import XCTest
@testable import MyEverest

class DateFormateTest: XCTestCase {
  func testDateToString() {
    let dateString = "16.05.1994"
    let date = dateString.toDate()
    XCTAssertNotNil(date)
    let convertBackString = date?.toString()
    XCTAssertNotNil(convertBackString)
    XCTAssertEqual(convertBackString, dateString)
    let convertBackDate = convertBackString?.toDate()
    XCTAssertNotNil(convertBackDate)
    XCTAssertEqual(convertBackDate, date)
  }
}
