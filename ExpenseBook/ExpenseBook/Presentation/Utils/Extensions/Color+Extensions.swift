//
//  Color+Extensions.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 05/10/22.
//

import SwiftUI
extension Color {
    init?(hex: String) {
        var sanitizedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        sanitizedHex = sanitizedHex.replacingOccurrences(of: "#", with: "")

        if sanitizedHex.count == 3 {
            sanitizedHex = sanitizedHex.components(separatedBy: "").map { "\($0)\($0)" }.joined()
        }

        var rgb: UInt64 = 0

        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0

        let length = sanitizedHex.count

        guard Scanner(string: sanitizedHex).scanHexInt64(&rgb) else { return nil }

        switch length {
        case 6:
            red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(rgb & 0x0000FF) / 255.0
        case 8:
            red = CGFloat((rgb & 0xFF00_0000) >> 24) / 255.0
            green = CGFloat((rgb & 0x00FF_0000) >> 16) / 255.0
            blue = CGFloat((rgb & 0x0000_FF00) >> 8) / 255.0
            alpha = CGFloat(rgb & 0x0000_00FF) / 255.0
        default:
            return nil
        }

        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }

    func toHexString() -> String? {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return nil
        }
        let red = Float(components[0])
        let green = Float(components[1])
        let blue = Float(components[2])
        var alpha = Float(1.0)

        if components.count >= 4 {
            alpha = Float(components[3])
        }

        var varArgs = [lroundf(red * 255),
                       lroundf(green * 255),
                       lroundf(blue * 255)]
        if alpha != Float(1.0) {
            varArgs.append(lroundf(alpha * 255))
        }
        let colorCode = alpha != Float(1.0) ? "%02lX%02lX%02lX%02lX" : "%02lX%02lX%02lX"
        return "#\(String(format: colorCode, varArgs))"
    }
}
