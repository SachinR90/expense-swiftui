//
//  SummaryFilterConfig.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 18/11/22.
//

import Combine
import SwiftUI

class SummaryFilterConfig: ObservableObject {
    @Published var fromDate: Date = .init()
    @Published var dateFilterType: DateFilterType = .monthAndYear
    @Published var filterExpanded: Bool = false
    private(set) var toDate: Date? = Date()

    private var subscribers: Set<AnyCancellable> = []

    init() {
        $fromDate.sink { [self] date in
            switch dateFilterType {
            case .day:
                toDate = date.endOfDay
            case .monthAndYear:
                toDate = date.endOfMonth
            }
        }.store(in: &subscribers)
        dateFilterType = .monthAndYear
        fromDate = Date()
    }

    func getStartDate() -> Date {
        switch dateFilterType {
        case .day:
            return fromDate.startOfDay
        case .monthAndYear:
            return fromDate.startOfMonth
        }
    }

    func getEndDate() -> Date? {
        switch dateFilterType {
        case .day:
            return toDate?.endOfDay
        case .monthAndYear:
            return toDate?.endOfMonth
        }
    }
}
