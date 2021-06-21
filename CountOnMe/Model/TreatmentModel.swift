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

    private var inputString: String = "0"

    private var elements: [String] {
        return inputString.components(separatedBy: " ")
    }

    private var priorityOperator: Bool {
        return (elements.firstIndex(of: "x") != nil) || (elements.firstIndex(of: "/") != nil)
    }

    // MARK: - FUNCTIONS

    func calculate() {
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
} // end of class TreatmentModel
