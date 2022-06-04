//
//  SplitExtension.swift
//  Calculator
//
//  Created by Kay on 2022/05/20.
//

extension String {
    func split(with target: Character) -> [String] {
        return self.split(separator: target).map{ String($0) }
    }
}
