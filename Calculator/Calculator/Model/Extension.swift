import Foundation

extension String {
    func split(with target: Character) -> [String] {
        let splitString = self.split(separator: target).map {
            String($0)
        }
        return splitString
    }
    
    func changeToDouble() -> Double {
        let doubleNumber = Double(self.replacingOccurrences(of: ",", with: "")) ?? 0
        return doubleNumber
    }
    
    func removeString(target: String) -> String {
        let removedString = self.replacingOccurrences(of: target, with: "")
        return removedString
    }
}

extension Double: CalculateItem {
}
