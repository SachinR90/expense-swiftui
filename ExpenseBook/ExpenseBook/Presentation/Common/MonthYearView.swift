//
//  MonthYearView.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 01/11/22.
//

import SwiftUI

struct MonthYearView: View {
    init(selectedDate: Binding<Date>) {
        _selectedDate = selectedDate
        _selectedYear = State(initialValue: Int(exactly: selectedDate.wrappedValue.year)!)
        _selectedMonth = State(initialValue: Int(exactly: selectedDate.wrappedValue.month - 1)!)
    }

    private let months: [String] = Calendar.current.monthSymbols
    private let years = Array(
        (Calendar.current.component(.year, from: Date()) - 15)
            ...
            Calendar.current.component(.year, from: Date()))

    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth: Int = 0

    @Binding var selectedDate: Date

    var body: some View {
        // Year View
        VStack(spacing: 0) {
            TagList(
                list: years.map { TagItem(title: "\($0)", id: $0) },
                selectedId: selectedYear
            )
            .selectedTextColor(.blue)
            .normalTextColor(.black.opacity(0.5))
            .selectedBackgroundColor(.white)
            .normalBackgroundColor(.white)
            .itemCornerRadius(0.0)
            .onItemSelected { year in
                selectedYear = year.id
                setDate(month: selectedMonth, year: selectedYear)
            }

            TagList(
                list: months.enumerated().map { TagItem(title: $1, id: $0) },
                selectedId: selectedMonth
            )
            .selectedTextColor(.blue)
            .normalTextColor(.black.opacity(0.5))
            .selectedBackgroundColor(.white)
            .normalBackgroundColor(.white)
            .itemCornerRadius(0.0)
            .onItemSelected { month in
                selectedMonth = month.id
                setDate(month: selectedMonth, year: selectedYear)
            }
            Divider()
        }
    }

    private func setDate(month: Int, year: Int) {
        let calendar = Calendar.current
        var component = calendar.dateComponents([.year, .month], from: selectedDate)
        component.year = year
        component.month = month + 1
        selectedDate = calendar.date(from: component)!
    }
}

struct MonthYearView_Previews: PreviewProvider {
    @State static var date: Date = .init()
    static var previews: some View {
        MonthYearView(selectedDate: $date)
    }
}
