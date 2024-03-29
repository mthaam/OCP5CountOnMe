//
//  TreatmentModel.swift
//  CountOnMe
//
//  Created by JEAN SEBASTIEN BRUNET on 19/6/21.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
// swiftlint:disable line_length
//

import Foundation

/// This class analyses the input calculation string
final class TreatmentModel {

    // MARK: - PROPERTIES

    /// This property represents the text View to be calcultated.
    /// It sends a notification every time the value changes, in didSet.
    var inputString: String = "1 + 1 = 2" {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("updateDisplay"),
                                            object: nil, userInfo: ["updateDisplay": inputString])
        }
    }

    /// This calculated property returns an array of strings values
    /// from the inputString property, whose entries are separated by a blank character.
    private var elements: [String] {
        return inputString.split(separator: " ").map { "\($0)" }
    }

    /// This calculated property determines if there is a priorty operator
    private var priorityOperator: Bool {
        return (elements.firstIndex(of: "x") != nil) || (elements.firstIndex(of: "/") != nil)
    }

    /// This calculated property determines if the expression is correct
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x"
    }

    /// This calculated property determines if the expression
    /// to be calculated has enough elements to perform calculation.
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    /// This calculated property determines if it is possible
    /// to add an operator when pressing an operator button.
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x"
    }

    /// This calculated property determines if the expression has
    /// already been calculated.
    private var expressionHaveResult: Bool {
        return inputString.firstIndex(of: "=") != nil
    }

    /// This calculated property determines if the last character
    /// of an expression is an operand.
    private var expressionLastCharIsOperand: Bool {
        return inputString.last == "+" || inputString.last == "-" || inputString.last == "/" || inputString.last == "x" || inputString.last == " "
    }

    /// This calculated property determines if the expression
    /// to be calculated contains a division by 0
    /// It calls the verify verifyDivisionByZero()
    private var expressionContainsADivisionBy0: Bool {
         return verifyDivisionByZero()
    }

    // MARK: - APPENDING NUMBERS AND OPERANDS FUNCTIONS

    /// This function appends the inputString property
    /// - Parameter numberText : a string value depending on the button touched up .
    func numberButtonTapped(numberText: String) {
        if expressionHaveResult {
            inputString = String()
        }
        inputString.append(numberText)
    }

    /// This function appends the inputText property with a + character
    func plusButtonTapped() {
        addOperand(with: " + ")
    }

    /// This function appends the inputText property with a - character
    func minusButtonTapped() {
        addOperand(with: " - ")
    }

    /// This function appends the inputText property with a x character
    func multiplyButtonTapped() {
        addOperand(with: " x ")
    }

    /// This function appends the inputText property with a / character
    func divideButtonTapped() {
        addOperand(with: " / ")
    }

    /// This function appends the inputString property
    /// - Parameter operand : a string value depending on the button touched up .
    private func addOperand(with operand: String) {
        if expressionHaveResult || inputString == "" {
            sendAlertNotification(message: "Start your calculation with a number.")
        } else if canAddOperator {
            inputString.append("\(operand)")
        } else {
            sendAlertNotification(message: "You already typed an Operator")
        }
    }

    /// This function clears the inputText property displaying calculation result
    func clear() {
        inputString = String()
    }

    /// This function deletes last character of InputString,
    /// or last 2 characters if it is an operand.
    func deleteLastEntry() {
        guard inputString.count >= 1 else { return }
        if expressionLastCharIsOperand {
            inputString.removeLast(3)
        } else {
            inputString.removeLast()
        }
    }

    // MARK: - MAIN CALCULATION FUNCTION

    /// This function is the main calculation function.
    /// It verifies the expression is correct, have enought
    /// elements and doesn't contains a division by 0.
    func calculate() {
        guard expressionHaveEnoughElement else {
            sendAlertNotification(message: "Not enough elements to perform calculation.\nTry again!")
            return
        }
        guard expressionIsCorrect else {
            sendAlertNotification(message: "Please enter a correct expression!")
            return
        }
        guard expressionHaveResult == false else {
            sendAlertNotification(message: "You must touch AC before starting a new calculation")
            return
        }
        guard expressionContainsADivisionBy0 == false else {
            sendAlertNotification(message: "Division by 0 is not allowed!")
            inputString.append(" = Error")
            return }

        var dynamicResolutionArray = elements

        if priorityOperator {
            dynamicResolutionArray = resolvePriorityCalculations(in: dynamicResolutionArray)
        }
        resolveNonPriorityCalculations(in: &dynamicResolutionArray)
        guard let currentResult = dynamicResolutionArray.first else { return }
        inputString.append(" = \(currentResult)")
    }

    // MARK: - PRIVATE FUNCTIONS

    /// This function returns a string Array.
    /// It resolves priority calculations while there are any.
    /// -  Parameter expression : a string array received.
    private func resolvePriorityCalculations(in expression: [String]) -> [String] {
        var temporaryExpression = expression

        while temporaryExpression.contains("x") || temporaryExpression.contains("/") {
            if let indexTempExpression = temporaryExpression.firstIndex(where: {$0 == "x" || $0 == "/"}) {

                let operand = temporaryExpression[indexTempExpression]

                guard let leftNumber = Double(temporaryExpression[indexTempExpression - 1]) else { return [] }
                guard let rightNumber = Double(temporaryExpression[indexTempExpression + 1]) else { return [] }

                var currentResult: Double = 0.0

                if operand == "x" {
                    currentResult = leftNumber * rightNumber
                } else {
                    currentResult = leftNumber / rightNumber
                }
                temporaryExpression[indexTempExpression - 1] = String(doubleToInteger(from: currentResult))
                temporaryExpression.remove(at: indexTempExpression + 1)
                temporaryExpression.remove(at: indexTempExpression)
            }
        }
        return temporaryExpression
    }

    /// This function returns a string Array.
    /// It resolves non priority calculations while there are any.
    /// -  Parameter expression : a string array received.
    private func resolveNonPriorityCalculations(in dynamicResolutionArray: inout [String]) {
        while dynamicResolutionArray.count > 1 {
            let leftOperandStrComma: String = dynamicResolutionArray[0]
            let leftOperandStrPoint = leftOperandStrComma.replacingOccurrences(of: ",", with: ".")
            let leftOperandDouble = Double(leftOperandStrPoint)

            let operatorPlusOrMinus = dynamicResolutionArray[1]

            let rightOperandStrComma: String = dynamicResolutionArray[2]
            let rightOperandStrPoint = rightOperandStrComma.replacingOccurrences(of: ",", with: ".")
            let rightOperandDouble = Double(rightOperandStrPoint)

            var currentResult: Double = 0.0

            switch operatorPlusOrMinus {
            case "+":
                if let leftOperandDoubleUnwrapped = leftOperandDouble, let rightOperandDoubleUnwrapped = rightOperandDouble {
                    currentResult = leftOperandDoubleUnwrapped + rightOperandDoubleUnwrapped
                }
            case "-":
                if let leftOperandDoubleUnwrapped = leftOperandDouble, let rightOperandDoubleUnwrapped = rightOperandDouble {
                    currentResult = leftOperandDoubleUnwrapped - rightOperandDoubleUnwrapped
                }
            default: break
            }
            dynamicResolutionArray = Array(dynamicResolutionArray.dropFirst(3))
            dynamicResolutionArray.insert("\(doubleToInteger(from: currentResult))", at: 0)
        }
    }

    /// This function returns a string value.
    /// It converts a received value into a string value after
    /// the , were removed.
    /// - Parameter currentResult : a Double value
    private func doubleToInteger(from currentResult: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = false
        formatter.maximumFractionDigits = 5
        let doubleAsString =  formatter.string(from: NSNumber(value: currentResult))!
        return doubleAsString
    }

    /// This function sends a notification
    /// - Parameter message : a string value describing the problem.
    private func sendAlertNotification(message: String) {
        let name = Notification.Name("alertDisplay")
        NotificationCenter.default.post(name: name, object: nil, userInfo: ["message": message])
    }

    /// This function receives returns a boolean value.
    /// It  iterates over the elements array
    /// to verify if there is a division  by 0.
    private func verifyDivisionByZero() -> Bool {
        var thereIsADivisionBy0 = false
        var count = 0
        for divide in elements {
            if divide == "/" && elements[count + 1] == "0" {
                thereIsADivisionBy0 = true
            }
            count += 1
        }
        return thereIsADivisionBy0
    }
} // end of class TreatmentModel
