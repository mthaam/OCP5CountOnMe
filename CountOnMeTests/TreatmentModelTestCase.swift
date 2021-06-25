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
//
    func testGivenInputStringHasAlreadyOneCharacter_WhenAddingANumber_ThenCalculTexPropertyCOntainsTheAddedNumber() {
        calculation.numberButtonTapped(numberText: "1")

        calculation.numberButtonTapped(numberText: "2")

        XCTAssert(calculation.inputString == "12")
    }

    func testGivenInputStringHasAlreadyOneCharacter_WhenAddingMinusSign_ThenCalculTexPropertyCOntainsTheMinusSign() {
        calculation.inputString = "1"

        calculation.minusButtonTapped()

        XCTAssert(calculation.inputString == "1 - ")
    }

    func testGivenInputStringHasAlreadyOneCharacter_WhenAddingPlusSign_ThenCalculTexPropertyCOntainsThePlusSign() {
        calculation.inputString = "1"

        calculation.plusButtonTapped()

        XCTAssert(calculation.inputString == "1 + ")
    }

    func testGivenInputStringHasAlreadyOneCharacter_WhenAddingMultiplySign_ThenCalculTexPropertyCOntainsTheMultiplySign() {
        calculation.inputString = "1"

        calculation.multiplyButtonTapped()

        XCTAssert(calculation.inputString == "1 x ")
    }

    func testGivenInputStringHasAlreadyOneCharacter_WhenDivideSign_ThenCalculTexPropertyCOntainsTheDivideSign() {
        calculation.inputString = "1"

        calculation.divideButtonTapped()

        XCTAssert(calculation.inputString == "1 / ")
    }

    func testGivenInputStringHasAlreadyOneCharacter_WhenClearing_ThenCalculTexPropertyCOntains0() {
        calculation.inputString = "1"

        calculation.clear()

        XCTAssert(calculation.inputString == "0")
    }

}
