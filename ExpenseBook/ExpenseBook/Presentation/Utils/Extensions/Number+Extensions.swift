//
//  NumberProtocol.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 21/10/22.
//

import Foundation
protocol NumberProtocol {}
extension NumberProtocol {
    func toLocalCurrency(decimalsDigits: Int = 2, style: NumberFormatter.Style = .currency) -> String {
        let formatter = NumberFormatter.formatter
        formatter.numberStyle = style
        formatter.maximumFractionDigits = decimalsDigits
        guard let newNumber = self as? NSNumber else { fatalError("this type is not convertable to NSNumber") }
        return formatter.string(from: newNumber)!
    }
}

extension UInt: NumberProtocol {}
extension Int: NumberProtocol {}
extension Float: NumberProtocol {}
extension Double: NumberProtocol {}

extension NumberFormatter {
    static let formatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.autoupdatingCurrent
        return numberFormatter
    }()
}
