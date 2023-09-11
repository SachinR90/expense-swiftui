//
//  Date+Extensions.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 19/10/22.
//

import Foundation
extension Date {
    var year: Int { Calendar.current.component(.year, from: self) }
    var month: Int { Calendar.current.component(.month, from: self) }
    var day: Int { Calendar.current.component(.day, from: self) }

    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var startOfMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        let date = calendar.date(from: components)!
        return date.startOfDay
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        let date = Calendar.current.date(byAdding: components, to: startOfMonth)!
        return date.endOfDay
    }

    var startOfYear: Date {
        let components = Calendar.current.dateComponents([.year], from: self)
        let date = Calendar.current.date(from: components)!
        return date
    }

    var endOfYear: Date {
        let year = Calendar.current.component(.year, from: self)
        let firstOfNextYear = Calendar.current.date(from: DateComponents(year: year + 1, month: 1, day: 1))!
        let lastOfYear = Calendar.current.date(byAdding: .day, value: -1, to: firstOfNextYear)!
        return lastOfYear.endOfDay
    }

    func defaultTime() -> Date {
        let cal = Calendar.current
        var component = cal.dateComponents([.day, .month, .year, .hour, .minute, .second, .nanosecond], from: self)
        component.hour = 12
        component.minute = 0
        component.second = 0
        component.nanosecond = 0
        let date = cal.date(from: component)!
        return date
    }

    func monthString(_ monthFormat: Date.FormatStyle.Symbol.Month = .wide) -> String {
        formatted(.dateTime.month(monthFormat))
    }

    func yearString(_ yearFormat: Date.FormatStyle.Symbol.Year = .defaultDigits) -> String {
        formatted(.dateTime.year(yearFormat))
    }

    func monthAndYearString(_ monthFormat: Date.FormatStyle.Symbol.Month = .abbreviated,
                            _ yearFormat: Date.FormatStyle.Symbol.Year = .defaultDigits) -> String {
        formatted(.dateTime.month(monthFormat).year(yearFormat))
    }

    func mediumDateString() -> String {
        formatted(.dateTime.day().month().year())
    }

    func fullDateString() -> String {
        formatted(date: .long, time: .omitted)
    }

    func nextNYearDate(_ count: Int) -> Date {
        let cal = Calendar.current
        var component = cal.dateComponents([.year], from: self)
        component.year = count
        let nextDate = Calendar.current.date(byAdding: component, to: self)
        return nextDate!
    }
}
