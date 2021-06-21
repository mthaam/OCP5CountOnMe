//
//  TreatmentModel.swift
//  CountOnMe
//
//  Created by JEAN SEBASTIEN BRUNET on 19/6/21.
//

import Foundation

/// This class analyses the input calculation string
class TreatmentModel {

    // MARK: - PROPERTIES

    private var inputString: String = "0" {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("updateDisplay"),
                                            object: nil, userInfo: ["updateDisplay": inputString])
        }
    }

    private var elements: [String] {
        return inputString.components(separatedBy: " ")
    }

    private var priorityOperator: Bool {
        return (elements.firstIndex(of: "x") != nil) || (elements.firstIndex(of: "/") != nil)
    }

    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x"
    } // to add

    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    } // ok

    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x"
    } // ok

    private var expressionHaveResult: Bool {
        return inputString.firstIndex(of: "=") != nil
    } // ok

    private var firstCalculation: Bool = true

    // MARK: - APPENDING NUMBERS AND OPERANDS FUNCTIONS

    /// This function appends the calculText property
    /// - Parameter numberText : a string value depending on the button touched up .
    func numberButtonTapped(numberText: String) {
        if expressionHaveResult || firstCalculation {
            inputString = ""
        }
        firstCalculation = false
        inputString.append(numberText)
    }

    /// This function appends the inputText property
    /// - Parameter operand : a string value depending on the button touched up .
    private func operandSignTapped(operand: String) {
        inputString.append("\(operand)")
    }

    /// This function appends the inputText property with a + character
    func plusButtonTapped() {
        if canAddOperator {
            operandSignTapped(operand: " + ")
        } else {
            sendAlertNotification(message: "You already typed an Operand")
        }
    }

    /// This function appends the inputText property with a + character
    func minusButtonTapped() {
        if canAddOperator {
            operandSignTapped(operand: " - ")
        } else {
            sendAlertNotification(message: "You already typed an Operand")
        }
    }

    /// This function appends the inputText property with a x character
    func multiplyButtonTapped() {
        if canAddOperator {
            operandSignTapped(operand: " x ")
        } else {
            sendAlertNotification(message: "You already typed an Operand")
        }
    }

    /// This function appends the inputText property with a / character
    func divideButtonTapped() {
        if canAddOperator {
            operandSignTapped(operand: " / ")
        } else {
            sendAlertNotification(message: "You already typed an Operand")
        }
    }

    /// This function clears the inputText property displaying calculation result
    func clear() {
        firstCalculation = true
        inputString = "0"
    }

    // MARK: - CALCULATION FUNCTION

    func calculate() {

        guard expressionIsCorrect else {
            sendAlertNotification(message: "Please enter a correct expression!")
            return
        }
        guard expressionHaveEnoughElement else {
            sendAlertNotification(message: "Not enough elements to perform calculation.\nTry again!")
            return
        }
        var dynamicResolutionArray = elements

        if priorityOperator {
            dynamicResolutionArray = resolvePriorityCalculations(in: dynamicResolutionArray)
        }

        resolveNonPriorityCalculations(in: &dynamicResolutionArray)

        guard let currentResult = dynamicResolutionArray.first else { return }
        inputString.append("\(currentResult)")

    }

    // MARK: - PRIVATE FUNCTIONS

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

    private func resolveNonPriorityCalculations(in dynamicResolutionArray: inout [String]) {
        while dynamicResolutionArray.count > 1 {
            let leftOperandStrComma: String = dynamicResolutionArray[0]
            let leftOperandStrPoint = leftOperandStrComma.replacingOccurrences(of: ",", with: ".")
            let leftOperandDouble = Double(leftOperandStrPoint)

            let operatorPlusOrMinus = dynamicResolutionArray[1]

            let rightOperandStrComma: String = dynamicResolutionArray[0]
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

    private func doubleToInteger(from currentResult: Double) -> String {
        let doubleAsString = NumberFormatter.localizedString(from: (NSNumber(value: currentResult)), number: .decimal)
        return doubleAsString
    }

    /// This function sends a notification
    /// - Parameter message : a string value describing the problem.
    private func sendAlertNotification(message: String) {
        let name = Notification.Name("alertDisplay")
        NotificationCenter.default.post(name: name, object: nil, userInfo: ["message": message])
    }
} // end of class TreatmentModel
