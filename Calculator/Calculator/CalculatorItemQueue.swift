//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by 이시원 on 2022/03/15.
//

import Foundation

protocol CalculateItem {
    
}

extension Int: CalculateItem {
    
}

class CalculatorItemQueue<T: CalculateItem> {
    let linkdeList = LinkdeList<T>()
    
    func enqueue(_ data: T) {
        linkdeList.append(data)
    }
}
