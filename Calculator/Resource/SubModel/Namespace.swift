//
//  KeyPadNamespace.swift
//  Calculator
//
//  Created by Kay on 2022/06/04.
//

import Foundation

struct NumberNamespace {
    
    //MARK: - Number
    static let zero: String = "0"
    static let doubleZero: String = "00"
    static let one: String = "1"
    static let two: String = "2"
    static let three: String = "3"
    static let four: String = "4"
    static let five: String = "5"
    static let six: String = "6"
    static let seven: String = "7"
    static let eight: String = "8"
    static let nine: String = "9"
    
    private init() { }
}


struct SymbolNamespace {
    
    //MARK: - Symbol
    static let empty: String = ""
    static let exclamation: String = "!"
    static let ampersand: String = "&"
    static let dot: String = "."
    static let addSign: String = String(Operator.add.rawValue)
    static let subtractSign: String = String(Operator.subtract.rawValue)
    static let multiplySign: String = String(Operator.multiply.rawValue)
    static let divideSign: String = String(Operator.divide.rawValue)
    static let equalSign: String = "="
    
    private init() { }
}
