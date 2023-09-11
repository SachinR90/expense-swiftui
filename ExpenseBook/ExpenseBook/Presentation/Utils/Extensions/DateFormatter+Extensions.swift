//
//  DateFormatter+Extensions.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 19/10/22.
//

import Foundation
extension DateFormatter {
    static let fullDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.autoupdatingCurrent
        return dateFormatter
    }()

    static let mediumDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.autoupdatingCurrent
        return dateFormatter
    }()
}
