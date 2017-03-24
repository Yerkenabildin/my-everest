//
//  UIColorTest.swift
//  NewYorkTimesCloneApp
//
//  Created by Yerkebulan Abildin on 23.07.17.
//  Copyright © 2017 Yerkebulan Abildin. All rights reserved.
//

import XCTest
@testable import MyEverest

class HexColorTest: XCTestCase {
  func testHexColor() {
    let color = UIColor.colorWithHexaCode("FFFFFF")
    XCTAssertNotNil(color)
    XCTAssertTrue(color == UIColor.white)
  }

  func testHexColorWithHash() {
    let color = UIColor.colorWithHexaCode("#FFFFFF")
    XCTAssertNotNil(color)
    XCTAssertTrue(color == UIColor.white)
  }

  func testHexColorWithOverLimit() {
    let color = UIColor.colorWithHexaCode("#FFFFFFFFFFFFFF")
    XCTAssertNotNil(color)
    XCTAssertTrue(color == UIColor.gray)
  }
}
