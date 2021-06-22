//
//  TreatmentModelTestCase.swift
//  CountOnMeTests
//
//  Created by JEAN SEBASTIEN BRUNET on 22/6/21.
//

import XCTest
@testable import CountOnMe

class TreatmentModelTestCase: XCTestCase {

        var calculation: TreatmentModel!

        override func setUp() {
            super.setUp()
            calculation = TreatmentModel()
        }

    func testGivenInputStringContainsAnExpression_WhenCallingDeleteLastFunction_ThenTheLastCharacterOfExpressionShouldBeDeleted() {
        calculation.inputString = "3 + 5 / 2"

        calculation.deleteLastEntry()

        XCTAssert(calculation.inputString == "3 + 5 / ")
    }

}
