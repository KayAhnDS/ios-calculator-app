//
//  Calculator - ViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentString: String = SymbolNamespace.empty
    var totalString: String = SymbolNamespace.empty
    
    @IBOutlet var stackView: UIStackView!
    
    // Buttons - Numbers
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var doubleZeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    
    // Buttons - Symbols
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    
    // Buttons - Functions
    @IBOutlet weak var acButton: UIButton!
    @IBOutlet weak var ceButton: UIButton!
    @IBOutlet weak var plusMinusButton: UIButton!
    
    // Labels - Associate with Result
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func tappedAllClear(_ sender: UIButton) {
        makeCurrentStringToEmpty()
        makeTotalStringToEmpty()
        makeSignLabelTextToEmpty()
        makeValueLabelTextToZero()
        makeStackViewToEmpty()
    }
    
    private func makeCurrentStringToEmpty() {
        currentString = SymbolNamespace.empty
    }
    
    private func makeTotalStringToEmpty() {
        totalString = SymbolNamespace.empty
    }
    
    private func makeSignLabelTextToEmpty() {
        signLabel.text = SymbolNamespace.empty
    }
    
    private func makeValueLabelTextToZero() {
        valueLabel.text = NumberNamespace.zero
    }

    private func makeStackViewToEmpty() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    private func mapSign(sender: UIButton) -> String {
        switch sender {
        case plusButton:
            return String(Operator.add.rawValue)
        case minusButton:
            return String(Operator.subtract.rawValue)
        case multiplyButton:
            return String(Operator.multiply.rawValue)
        case divideButton:
            return String(Operator.divide.rawValue)
        default:
            return ""
        }
    }
    
    private func determineTotalStringByDashCharacterCondition(value: String) {
        if value.contains(NumberNamespace.minusSign) {
            totalString += "&\(value.dropFirst())"
        } else {
            totalString += value
        }
    }
    
    private func resetValueLabelandCurrentString() {
        makeValueLabelTextToZero()
        makeCurrentStringToEmpty()
    }
    private func addLabelandSign (value: String, sender: UIButton) {
        addNewLabel(message: value, stackView: stackView)
        signLabel.text = mapSign(sender: sender)
    }
    
    // 연산자 입력
    @IBAction private func tappedOperatorIntoEquation(_ sender: UIButton) {
        guard currentString.count != 0 && valueLabel.text != SymbolNamespace.empty else {
            return
        }
        if totalString.isEmpty {
            guard let value = valueLabel.text else { return }
            determineTotalStringByDashCharacterCondition(value: value)
            addLabelandSign(value: value, sender: sender)
            resetValueLabelandCurrentString()
            
        } else {
            if valueLabel.text == NumberNamespace.zero {
                signLabel.text = mapSign(sender: sender)
            } else {
                guard let retrievedSign = signLabel.text else { return }
                guard let retrievedValue = valueLabel.text else { return }
                makeCurrentStringToEmpty()
                totalString += retrievedSign
                determineTotalStringByDashCharacterCondition(value: retrievedValue)
                addLabelandSign(value: retrievedSign + retrievedValue, sender: sender)
                resetValueLabelandCurrentString()
            }
        }
    }
    
    // 숫자 입력
    @IBAction func tappedOperandIntoEquation(_ sender: UIButton) {
        switch sender {
        case oneButton:
            currentString += NumberNamespace.one
        case twoButton:
            currentString += NumberNamespace.two
        case threeButton:
            currentString += NumberNamespace.three
        case fourButton:
            currentString += NumberNamespace.four
        case fiveButton:
            currentString += NumberNamespace.five
        case sixButton:
            currentString += NumberNamespace.six
        case sevenButton:
            currentString += NumberNamespace.seven
        case eightButton:
            currentString += NumberNamespace.eight
        case nineButton:
            currentString += NumberNamespace.nine
        case zeroButton:
            if currentString == NumberNamespace.zero {
                return
            }
            currentString += NumberNamespace.zero
        case doubleZeroButton:
            if currentString.isEmpty {
                return
            }
            currentString += NumberNamespace.doubleZero
        case dotButton:
            if currentString.isEmpty || currentString.contains(NumberNamespace.dot) {
                return
            }
            currentString += NumberNamespace.dot
        default:
            currentString += SymbolNamespace.empty
        }
        valueLabel.text = currentString
    }
    
    // 실제 계산
    @IBAction private func tappedCalculateFormula(_ sender: UIButton) {
        if totalString.isEmpty {
            return
        }else {
            guard let sign = signLabel.text else { return }
            guard let value = valueLabel.text else { return }
            currentString = "\(sign)\(value)"
            addNewLabel(message: currentString, stackView: stackView)
            totalString += sign
            if value.contains(Operator.subtract.rawValue) {
                totalString += "&\(value.dropFirst())"
            } else {
                totalString += value
            }
            
            var finalEquation = ExpressionParser.parse(from: totalString)
            do {
                let result = try finalEquation.result()
                valueLabel.text = String(result)
            } catch ValueError.operandEmpty {
                displaySignAndValueLabels(signMessage: "!", valueMessage: "Need an Operand")
            } catch ValueError.operatorEmpty {
                displaySignAndValueLabels(signMessage: "!", valueMessage: "Need an Operator")
            } catch ValueError.divideByZero {
                displaySignAndValueLabels(signMessage: "", valueMessage: "NaN")
            } catch {
                displaySignAndValueLabels(signMessage: "error", valueMessage: "error")
            }
            signLabel.text = SymbolNamespace.empty
            totalString = SymbolNamespace.empty
            currentString = SymbolNamespace.empty
        }
    }
    
    @IBAction private func tappedCeExecution(sender: UIButton) {
        if currentString.isEmpty && totalString.isEmpty {
            valueLabel.text = NumberNamespace.zero
        } else {
            valueLabel.text = SymbolNamespace.empty
        }
        currentString = SymbolNamespace.empty
    }
    
    @IBAction private func tappedPlusMinusSwap(sender: UIButton) {
        guard let value = valueLabel.text else { return }
        if value.contains(Operator.subtract.rawValue) {
            valueLabel.text = String(value.dropFirst())
        } else {
            if value == NumberNamespace.zero {
                return
            }
            valueLabel.text = "-\(value)"
        }
    }
    
    private func addNewLabel(message: String, stackView: UIStackView) {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.isHidden = true
        label.text = "\(message)"
        label.textAlignment = .right
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        stackView.addArrangedSubview(label)
        UIView.animate(withDuration: 0.3) {
            label.isHidden = false
        }
    }
    
    private func displaySignAndValueLabels(signMessage: String, valueMessage: String) {
        signLabel.text = signMessage
        valueLabel.text = valueMessage
    }
}

