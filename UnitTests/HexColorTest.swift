//
//  UIColorTest.swift
//  NewYorkTimesCloneApp
//
//  Created by Yerkebulan Abildin on 23.07.17.
//  Copyright © 2017 Yerkebulan Abildin. All rights reserved.
//

import Quick
import Nimble
@testable import MyEverest

class HexColorTest: QuickSpec {
  override func spec() {
    describe("Color from hex") {
      it("Without prefix") {
        let color = UIColor.colorWithHexaCode("FFFFFF")
        expect(color).toNot(beNil())
        expect(color == UIColor.white).to(beTrue())
      }

      it("With prefix") {
        let color = UIColor.colorWithHexaCode("#FFFFFF")
        expect(color).toNot(beNil())
        expect(color == UIColor.white).to(beTrue())
      }

      it("Wrong format") {
        let color = UIColor.colorWithHexaCode("FFFFFFFFFFFFFF")
        expect(color).toNot(beNil())
        expect(color == UIColor.gray).to(beTrue())
      }
    }
  }
}
