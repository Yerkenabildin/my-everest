//
//  DateFormateTest.swift
//  MyEverest
//
//  Created by Yerkebulan Abildin on 16.08.17.
//  Copyright © 2017 abild.in. All rights reserved.
//

import Quick
import Nimble
@testable import MyEverest

class DateFormateTest: QuickSpec {
  override func spec() {
    describe("DateFormater") {
      it("From String To Date And Back") {
        let dateString = "16.05.1994"
        let date = dateString.toDate()
        expect(date).toNot(beNil())
        let convertBackString = date?.toString()
        expect(convertBackString).toNot(beNil())
        expect(convertBackString).to(equal(dateString))
        let convertBackDate = convertBackString?.toDate()
        expect(convertBackDate).toNot(beNil())
        expect(convertBackDate).to(equal(date))
      }
    }
  }
}
