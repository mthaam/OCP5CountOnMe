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

    private var isThereAPriorityOperator: Bool {
        return (elements.firstIndex(of: "x") != nil) || (elements.firstIndex(of: "/") != nil)
    }

    // MARK: - FUNCTIONS

    func calculate() {
        var dynamicResolutionArray = elements
    
        if isThereAPriorityOperator {
            dynamicResolutionArray = resolvePriorityCalculations(in: dynamicResolutionArray)
        }
        
    }

    // MARK: - PRIVATE FUNCTIONS

    private func resolvePriorityCalculations(in expression: [String]) -> [String] {
        var temporaryExpression = expression
        
        while temporaryExpression.contains("x") || temporaryExpression.contains("/") {
            <#code#>
        }
        
        return temporaryExpression
    }
    


    
}
