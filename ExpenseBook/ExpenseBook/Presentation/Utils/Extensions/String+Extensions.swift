//
//  String+Extensions.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 27/09/22.
//

import SwiftUI
extension String {
    var isHexNumber: Bool {
        filter(\.isHexDigit).count == count
    }

    var capitalizedFirst: String {
        prefix(1).capitalized + dropFirst()
    }

    func deletingPrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }

    func toColor() -> Color? {
        isValidColor() ? Color(hex: self)! : nil
    }

    func isValidColor() -> Bool {
        if isEmpty {
            return false
        }
        var hashBasedString = lowercased()
        if !hashBasedString.hasPrefix("#") {
            hashBasedString = "#\(hashBasedString)"
        }
        let colorRegex = "(?:#)(?:[a-f0-9]{3}|[a-f0-9]{6}|[a-f0-9]{8})\\b"
        let colorRegexPredicate = NSPredicate(format: "SELF MATCHES %@", colorRegex)
        return colorRegexPredicate.evaluate(with: hashBasedString)
    }

    func toMediumDate() -> Date? {
        DateFormatter.mediumDateFormatter.date(from: self)
    }
}

extension Optional where Wrapped == String {
    var isEmptyOrNil: Bool {
        self?.isEmpty ?? true
    }
}
