//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by JEAN SEBASTIEN BRUNET on 14/6/21.
//

import XCTest
@testable import CountOnMe

class CalculationModelTestCase: XCTestCase {

    var calculation: CalculationModel!

    override func setUp() {
        super.setUp()
        calculation = CalculationModel()
    }

    func testGivenCalculTexPropertyHasAlreadyOneCharacter_WhenAddingANumber_ThenCalculTexPropertyCOntainsTheAddedNumber() {
        calculation.calculText = "1"

        calculation.numberButtonTapped(numberText: "2")

        XCTAssert(calculation.calculText == "12")
    }

    func testGivenCalculTexPropertyHasAlreadyOneCharacter_WhenAddingMinusSign_ThenCalculTexPropertyCOntainsTheMinusSign() {
        calculation.calculText = "1"

        calculation.minusButtonTapped()

        XCTAssert(calculation.calculText == "1 - ")
    }

    func testGivenCalculTexPropertyHasAlreadyOneCharacter_WhenAddingPlusSign_ThenCalculTexPropertyCOntainsThePlusSign() {
        calculation.calculText = "1"

        calculation.plusButtonTapped()

        XCTAssert(calculation.calculText == "1 + ")
    }

    func testGivenCalculTexPropertyHasAlreadyOneCharacter_WhenAddingMultiplySign_ThenCalculTexPropertyCOntainsTheMultiplySign() {
        calculation.calculText = "1"

        calculation.multiplyButtonTapped()

        XCTAssert(calculation.calculText == "1 x ")
    }

    func testGivenCalculTexPropertyHasAlreadyOneCharacter_WhenDivideSign_ThenCalculTexPropertyCOntainsTheDivideSign() {
        calculation.calculText = "1"

        calculation.divideButtonTapped()

        XCTAssert(calculation.calculText == "1 / ")
    }

    func testGivenCalculTexPropertyHasAlreadyOneCharacter_WhenAddingEqualSign_ThenCalculTexPropertyCOntainsTheEqualSign() {
        calculation.calculText = "1"

        calculation.equalButtonTapped()

        XCTAssert(calculation.calculText == "1 = ")
    }

    func testGivenCalculTexPropertyHasAlreadyOneCharacter_WhenClearing_ThenCalculTexPropertyCOntains0() {
        calculation.calculText = "1"

        calculation.clear()

        XCTAssert(calculation.calculText == "0")
    }
}
