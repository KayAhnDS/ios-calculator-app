//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var operandLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var calculationHistory: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
    }
    
    func reset() {
        operandLabel.text = "0"
        operatorLabel.text = ""
    }
    
    @IBAction func touchUpNumberPadButton(_ sender: UIButton) {
        guard let operandLabelText = operandLabel.text else {
            return
        }
        
        guard let tapedNumber = sender.titleLabel?.text else {
            return
        }
        
        if operandLabelText == "0" {
            if tapedNumber == "0" || tapedNumber == "00" {
                return
            }
        }
        
        operandLabel.text = operandLabelText + tapedNumber
        
    }
}

