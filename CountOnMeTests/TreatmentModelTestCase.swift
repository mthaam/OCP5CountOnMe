//
//  TreatmentModelTestCase.swift
//  CountOnMeTests
//
//  Created by JEAN SEBASTIEN BRUNET on 22/6/21.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
// swiftlint:disable line_length
//

import XCTest
@testable import CountOnMe

class TreatmentModelTestCase: XCTestCase {

        var calculation: TreatmentModel!

        override func setUp() {
            super.setUp()
            calculation = TreatmentModel()
        }

    // MARK: - TESTS FOR ADDING / DELETING NUMBERS OR OPERANDS

    func testGivenInputStringContainsAnExpression_WhenCallingDeleteLastFunction_ThenTheLastCharacterOfExpressionShouldBeDeleted() {
        calculation.inputString = "3 + 5 / 2"

        calculation.deleteLastEntry()

        XCTAssert(calculation.inputString == "3 + 5 / ")
    }

    func testGivenInputStringHasAlreadyOneCharacter_WhenAddingANumber_ThenCalculTexPropertyCOntainsTheAddedNumber() {
        calculation.numberButtonTapped(numberText: "1")

        calculation.numberButtonTapped(numberText: "2")

        XCTAssert(calculation.inputString == "12")
    }

    func testGivenInputStringHasAlreadyOneCharacter_WhenAddingMinusSign_ThenCalculTexPropertyCOntainsTheMinusSign() {
        calculation.numberButtonTapped(numberText: "1")

        calculation.minusButtonTapped()

        XCTAssert(calculation.inputString == "1 - ")
    }

    func testGivenInputStringHasAlreadyOneCharacter_WhenAddingPlusSign_ThenCalculTexPropertyCOntainsThePlusSign() {
        calculation.numberButtonTapped(numberText: "1")

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

        XCTAssert(calculation.inputString == "")
    }

    func testGivenAnExpressionLastCharacterIsAnOperand_WhenTryingtoDeleteLastEntry_ThenTheLastCharacterIsDeleted() {
        calculation.inputString = "28 / 4 + 2 + 8 - 19 + 126 x 4 / "

        calculation.deleteLastEntry()

        XCTAssertTrue(calculation.inputString == "28 / 4 + 2 + 8 - 19 + 126 x 4 ")
    }

    func testGivenACalculationHasBeenPreviouslyMade_WhenStartingANewCalculationWithPressingAnOperator_ThenInputStringShouldBeUnchanged() {
        calculation.inputString = "4 x 7 = 28"

        calculation.minusButtonTapped()

        XCTAssertTrue(calculation.inputString == "4 x 7 = 28")
    }

    // MARK: - TESTS FOR CONTROLING CALCULATION RESULTS AND ERROR MANAGEMENT

    func testGivenAnExpressionContainsOnly2Elements_WhenCalcultating_TheInitialExpressionShouldBeUnchanged() {
        calculation.inputString = "26 / "

        calculation.calculate()

        XCTAssertTrue(calculation.inputString == "26 / ")
    }

    func testGivenAnInvalidExpressionIsEntered_WhenCalculating_ThenExpressionShouldBeUnchanged() {
        calculation.inputString = "26 / 2 + "

        calculation.calculate()

        XCTAssertTrue(calculation.inputString == "26 / 2 + ")
    }

    func testGivenInputStringContainesADivisionBy0_WhenPressingEqual_ThenInputStringShouldBeAppendedWithError() {
        calculation.inputString = "26 / 0"

        calculation.calculate()

        XCTAssert(calculation.inputString == "26 / 0 = Error")
    }

    func testGivenAnExpressionLastSignIsAnOperand_WhenTryingToAddAnotherOperand_ThenInitialExpressionShouldBeUnchanged() {
        calculation.inputString = "26 / 2 + "

        calculation.divideButtonTapped()
        calculation.minusButtonTapped()
        calculation.plusButtonTapped()
        calculation.multiplyButtonTapped()

        XCTAssertFalse(calculation.inputString == "26 / 2 + / ")
    }

    func testGivenAnInsufficientExpressionIsEntered_WhenAttemptToCalculate_ThenCalculationShouldBeAbortedAndInputExpressionUnchanged() {
        calculation.inputString = "26 / "

        calculation.calculate()

        XCTAssertTrue(calculation.inputString == "26 / ")
    }

    func testGivenAnExpressionWithASinglePrioritaryOperationIsInInputString_WhenCalculated_ThenResultIsCorrectAndPriorityIsConsidered() {
        calculation.inputString = "28 / 4 + 2"

        calculation.calculate()

        XCTAssertTrue(calculation.inputString == "28 / 4 + 2 = 9")
    }

    func testGivenAnExpressionWithMultiplePrioritaryOperationIsInInputString_WhenCalculated_ThenResultIsCorrectAndPrioritiesAreConsidered() {
        calculation.inputString = "28 / 4 + 2 + 8 - 19 + 126 x 4 / 2"

        calculation.calculate()

        XCTAssertTrue(calculation.inputString == "28 / 4 + 2 + 8 - 19 + 126 x 4 / 2 = 250")
    }

} // end of TreatmentModelTestCase
