//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var listScrollView: UIScrollView!
    @IBOutlet weak var numberListStackView: UIStackView!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var operandLabel: UILabel!
    var isNoneNumber: Bool = true
    var isFirst: Bool = true
    var isResult: Bool = false
    var calculationFormula = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBasicStatus()
    }
    //MARK: - IBAction
    @IBAction func touchACButton(_ sender: UIButton) {
        setBasicStatus()
    }
    
    @IBAction func touchCEButton(_ sender: UIButton) {
        self.operandLabel.text = "0"
        self.isNoneNumber = true
        if self.calculationFormula.isEmpty {
            self.isFirst = true
        }
    }
    
    @IBAction func touchChangeSignButton(_ sender: UIButton) {
        guard let operandText = self.operandLabel.text else { return }
        if operandText == "0" { return }
        if operandText.contains("-") {
            self.operandLabel.text = operandText.replacingOccurrences(of: "-", with: "")
        } else {
            self.operandLabel.text = "-" + operandText
        }
    }
    
    @IBAction func touchNumberButton(_ sender: UIButton) {
        guard let operandText = self.operandLabel.text, operandText.count < 20 else { return }
        guard let inputNumber = sender.titleLabel?.text else { return }
        if operandText == "NaN" || isResult == true {
            self.operandLabel.text = inputNumber
        } else {
            self.operandLabel.text = self.showZeroAfterDot(number: operandText + inputNumber)
        }
        self.isNoneNumber = false
        self.isFirst = false
        self.isResult = false
    }
    
    @IBAction func touchDotButton(_ sender: UIButton) {
        guard let operandText = self.operandLabel.text else { return }
        if operandText.contains(".") { return }
        self.operandLabel.text = operandText + "."
    }
    
    @IBAction func touchOperationButton(_ sender: UIButton) {
        guard let inputOperation = sender.titleLabel?.text else { return }
        guard let operandText = self.operandLabel.text else { return }
        guard let operationText = self.operationLabel.text else { return }
        if isFirst == true { return }
        self.operationLabel.text = inputOperation
        if isNoneNumber == true { return }
        addFormula(operation: operationText, operand: operandText)
        self.operandLabel.text = "0"
        self.isNoneNumber = true
        listScrollView.scrollToBottom(labelStackView: numberListStackView)
    }
    
    @IBAction func touchResultButton(_ sender: UIButton) {
        if self.isResult == true { return }
        if self.numberListStackView.subviews.isEmpty { return }
        guard let operandText = self.operandLabel.text else { return }
        guard let operationText = self.operationLabel.text else { return }
        addFormula(operation: operationText, operand: operandText)
        var resultFormula = ExpressionParser.parse(from: self.calculationFormula)
        let result = resultFormula.result()
        if result.isNaN {
            self.isFirst = true
        }
        self.operandLabel.text = changeNumberFormat(number: String(result))
        self.operationLabel.text = ""
        self.calculationFormula = ""
        self.isResult = true
    }
    //MARK: - Functions
    func setBasicStatus() {
        self.numberListStackView.subviews.forEach({$0.removeFromSuperview()})
        self.operandLabel.text = "0"
        self.operationLabel.text = ""
        self.calculationFormula = ""
        self.isNoneNumber = true
        self.isFirst = true
    }
    
    func showZeroAfterDot(number: String) -> String {
        if number.contains(".") && number.last == "0" { return number }
        return changeNumberFormat(number: number)
    }
    
    func changeToDouble(number: String) -> Double {
        return Double(number.replacingOccurrences(of: ",", with: "")) ?? 0
    }
    
    func changeNumberFormat(number: String) -> String {
        let number = changeToDouble(number: number)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 20
        guard let changedNumber = numberFormatter.string(from: number as NSNumber) else { return "" }
        if changedNumber == "-0" { return "0"}
        return changedNumber
    }
    
    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }
    
    func makeLabel(element: String) -> UILabel {
        let label = UILabel()
        label.text = element
        label.textColor = .white
        return label
    }
    
    func addFormula(operation: String, operand: String) {
        self.calculationFormula = "\(self.calculationFormula) \(operation) \(String(changeToDouble(number: operand)))"
        let numberStackView = makeStackView()
        numberStackView.addArrangedSubview(makeLabel(element: operation))
        numberStackView.addArrangedSubview(makeLabel(element: changeNumberFormat(number: operand)))
        self.numberListStackView.addArrangedSubview(numberStackView)
    }
}

extension UIScrollView {
    func scrollToBottom(labelStackView: UIStackView) {
        layoutIfNeeded()
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        setContentOffset(bottomOffset, animated: true)
    }
}
