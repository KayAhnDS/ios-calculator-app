//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class OperandButton: UIButton {
    var value: String?
}

class OperatorButton: UIButton {
    var value: String?
}

class FunctionalButton: UIButton {
    
}

class ViewController: UIViewController {
    static let defaultOperand: String = "0"
    var formulaNotYetCalculated: String = ""
    var calculator: Formula = Formula()
    var statusZeroFlag: Bool = true
    
    var inputtingOperand: String = defaultOperand {
        didSet {
            NumberLabel.text = inputtingOperand
        }
    }
    var inputtingOperator: String = "" {
        didSet {
            OperatorLabel.text = inputtingOperator
        }
    }
    
    let numberFormatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpOperandValue()
        setUpOpertorValue()
        
        OperatorLabel.text = ""
        NumberLabel.text = "0"
        setUpNumberFormat()
    }
    
    func setUpNumberFormat() {
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 20
        numberFormatter.roundingMode = .halfUp
    }
    
    @IBOutlet var OperandButtons: [OperandButton]!
    
    @IBOutlet weak var OperandZeroButton: OperandButton!
    @IBOutlet weak var OperandCoupleZeroButton: OperandButton!
    @IBOutlet weak var OperandOneButton: OperandButton!
    @IBOutlet weak var OperandTwoButton: OperandButton!
    @IBOutlet weak var OperandThreeButton: OperandButton!
    @IBOutlet weak var OperandFourButton: OperandButton!
    @IBOutlet weak var OperandFiveButton: OperandButton!
    @IBOutlet weak var OperandSixButton: OperandButton!
    @IBOutlet weak var OperandSevenButton: OperandButton!
    @IBOutlet weak var OperandEightButton: OperandButton!
    @IBOutlet weak var OperandNineButton: OperandButton!
    @IBOutlet weak var OperandDotButton: OperandButton!
    
    
    @IBOutlet var OperatorButtons: [OperatorButton]!
    
    @IBOutlet weak var OperatorAddButton: OperatorButton!
    @IBOutlet weak var OperatorSubtractButton: OperatorButton!
    @IBOutlet weak var OperatorMultiplyButton: OperatorButton!
    @IBOutlet weak var OperatorDivideButton: OperatorButton!
    
    
    @IBOutlet weak var FuncAllClearButton: FunctionalButton!
    @IBOutlet weak var FuncClearEntryButton: FunctionalButton!
    @IBOutlet weak var FuncChangeSignButton: FunctionalButton!
    @IBOutlet weak var FuncExecuteButton: FunctionalButton!
    
  
    @IBOutlet weak var OperatorLabel: UILabel!
    @IBOutlet weak var NumberLabel: UILabel!
    
    func setUpOperandValue() {
        OperandZeroButton.value = "0"
        OperandCoupleZeroButton.value = "00"
        OperandOneButton.value = "1"
        OperandTwoButton.value = "2"
        OperandThreeButton.value = "3"
        OperandFourButton.value = "4"
        OperandFiveButton.value = "5"
        OperandSixButton.value = "6"
        OperandSevenButton.value = "7"
        OperandEightButton.value = "8"
        OperandNineButton.value = "9"
        OperandDotButton.value = "."
    }
    
    func setUpOpertorValue() {
        OperatorAddButton.value = " + "
        OperatorSubtractButton.value = " - "
        OperatorMultiplyButton.value = " × "
        OperatorDivideButton.value = " ÷ "
    }
    
    @IBAction func OperandButtonAction(_ sender: OperandButton) {
        guard let input = sender.value else { return }
          
        if statusZeroFlag == true {
            if sender == OperandZeroButton || sender == OperandCoupleZeroButton {
                inputtingOperand = ViewController.defaultOperand
            } else if sender == OperandDotButton {
                inputtingOperand += input
            } else {
                inputtingOperand = input
            }
            statusZeroFlag = false
        } else {
            inputtingOperand += input
        }
        
        if !inputtingOperator.isEmpty {
            let lastInputtedOperator = OperatorLabel.text
            formulaNotYetCalculated += inputtingOperator
            inputtingOperator = ""
            OperatorLabel.text = lastInputtedOperator
        }
    }
    
    @IBAction func OperatorButtonAction(_ sender: OperatorButton) {
        guard let input = sender.value else { return }
        inputtingOperator = input
        if statusZeroFlag == true {
            return
        }
        
        formulaNotYetCalculated += inputtingOperand
        inputtingOperand = ViewController.defaultOperand
        statusZeroFlag = true
    }
    
    
    @IBAction func FunctionalButtonAction(_ sender: FunctionalButton) {
        switch sender {
        case FuncAllClearButton:
            inputtingOperand = ViewController.defaultOperand
            formulaNotYetCalculated = ""
            inputtingOperator = ""
            statusZeroFlag = true
            
        case FuncClearEntryButton:
            inputtingOperand = ViewController.defaultOperand
            statusZeroFlag = true
            
            
        case FuncChangeSignButton:
            if inputtingOperand == ViewController.defaultOperand {
                return
            } else if inputtingOperand.first == "-" {
                inputtingOperand.remove(at: inputtingOperand.startIndex)
            } else {
                inputtingOperand.insert("-", at: inputtingOperand.startIndex)
            }
            
        case FuncExecuteButton:
            if formulaNotYetCalculated.isEmpty {
                return
            }
            formulaNotYetCalculated += inputtingOperand
            inputtingOperand = ViewController.defaultOperand
            
            var parser = ExpressionParser.parse(from: formulaNotYetCalculated)
            formulaNotYetCalculated = ""
            inputtingOperand = ViewController.defaultOperand
            statusZeroFlag = true
            inputtingOperator = ""
            
            guard let result = try? parser.result() as Double else { return }
            if result.isNaN {
                NumberLabel.text = "NaN"
            } else {
                guard let numberFormattedResult = numberFormatter.string(for: result) else { return }
                NumberLabel.text = numberFormattedResult
            }
        default:
            return
        }
    }
}

