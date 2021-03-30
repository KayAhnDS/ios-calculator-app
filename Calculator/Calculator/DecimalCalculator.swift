//
//  DecimalCalculator.swift
//  Calculator
//
//  Created by Neph on 2021/03/23.
//
import Foundation

final class DecimalCalculator: Computable, Resettable {
    
    struct StackForDecimalCalculator {
        var number: String
        var operatorType: Operator
    }
    
    var stack = Stack<StackForDecimalCalculator>()
    
    func multiply(firstNumber: Double, secondNumber: Double) -> Double {
        return firstNumber * secondNumber
    }
    
    func divide(firstNumber: Double, secondNumber: Double) -> Double {
        return firstNumber / secondNumber
    }
    
    func formatInput(_ userInput: String?) throws -> Double {
        guard let input = userInput,
              let castedInput = Double(input) else {
            throw CalculatorError.formatError
        }
        return castedInput
    }
    
    func formatResult(of result: Double) throws -> String {
        var result = result
        
        if result >= 1e9 {
            result = result.truncatingRemainder(dividingBy: 1e9)
        }
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 9
        
        guard let formattedResult = formatter.string(from: NSNumber(value: result)) else {
            throw CalculatorError.formatError
        }
        
        return formattedResult
    }
    
    func reset() {
        stack.reset()
    }
    
}
