//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var numberListStackView: UIStackView!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var operandLabel: UILabel!
    
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
    }
    
    @IBAction func touchChangeSignButton(_ sender: UIButton) {
        guard let labelOperand = self.operandLabel.text else { return }
        if labelOperand == "0" { return }
        if labelOperand.contains("-") {
            self.operandLabel.text = labelOperand.replacingOccurrences(of: "-", with: "")
        } else {
            self.operandLabel.text = "-" + labelOperand
        }
    }
    
    @IBAction func touchNumberButton(_ sender: UIButton) {
        guard let labelOperand = self.operandLabel.text else { return }
        guard let inputNumber = sender.titleLabel?.text else { return }
        self.operandLabel.text = self.changeNumberFormat(number: labelOperand + inputNumber)
    }
    @IBAction func touchDotButton(_ sender: UIButton) {
        guard let labelOperand = self.operandLabel.text else { return }
        if labelOperand.contains(".") { return }
        self.operandLabel.text = labelOperand + "."
    }
    //MARK: - Functions
    func setBasicStatus() {
        self.numberListStackView.subviews.forEach({$0.removeFromSuperview()})
        self.operandLabel.text = "0"
        self.operationLabel.text = ""
    }
    
    func changeNumberFormat(number: String) -> String {
        if number.contains(".") && number.last == "0" { return number}
        guard let number = Double(number.replacingOccurrences(of: ",", with: "")) else { return "" }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumSignificantDigits = -2
        guard let changedNumber = numberFormatter.string(from: NSNumber(value: number)) else { return "" }
        return changedNumber
    }
    
    func setStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }
    
    func setLabel(element: String) -> UILabel {
        let label = UILabel()
        label.text = element
        return label
    }
}

