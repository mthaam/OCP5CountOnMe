//
//  calculationModel.swift
//  CountOnMe
//
//  Created by JEAN SEBASTIEN BRUNET on 14/6/21.
//

import Foundation

class CalculationModel {

    // MARK: - Properties

    var calculText: String = "0" {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("updateDisplay"),
                                            object: nil, userInfo: ["updateDisplay": calculText])
        }
    }

    // MARK: - Calculation Functions

    /// This function appends the calculText property
    /// - Parameter numberText : a string value depending on the button touched up .
    func numberButtonTapped(numberText: String) {
        calculText.append(numberText)
    }

    /// This function appends the calculText property
    /// - Parameter operand : a string value depending on the button touched up .
    private func operandSignTapped(operand: String) {
        calculText.append("\(operand)")
    }

    /// This function appends the calculText property with a + character
    func plusButtonTapped() {
        operandSignTapped(operand: " + ")
    }

    /// This function appends the calculText property with a - character
    func minusButtonTapped() {
        operandSignTapped(operand: " - ")
    }

    /// This function appends the calculText property with a x character
    func multiplyButtonTapped() {
        operandSignTapped(operand: " x ")
    }

    /// This function appends the calculText property with a / character
    func divideButtonTapped() {
        operandSignTapped(operand: " / ")
    }

    /// This function appends the calculText property with a = character
    func equalButtonTapped() {
        operandSignTapped(operand: " = ")
    }

    /// This function clears the textView displaying calculation result
    func clear() {
        calculText = "0"
    }
}
