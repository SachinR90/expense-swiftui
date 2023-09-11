//
//  SummaryScreenFilter.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 18/11/22.
//

import SwiftUI
struct SummaryScreenFilterView: View {
    @EnvironmentObject private var filterConfig: SummaryFilterConfig
    var body: some View {
        VStack(spacing: 4.0) {
            SummaryScreenFilterHeader()
            if filterConfig.filterExpanded {
                VStack(spacing: 16.0) {
                    HStack {
                        Text("Select a filter").fontWeight(.medium)
                        Spacer()
                        Picker("", selection: $filterConfig.dateFilterType.animation()) {
                            ForEach(DateFilterType.allCases, id: \.self) { Text("\($0.rawValue.capitalized)").tag($0) }
                        }
                        .pickerStyle(.segmented)
                        .fixedSize()
                    }
                    Group {
                        switch filterConfig.dateFilterType {
                        case .day:
                            DatePicker(
                                selection: $filterConfig.fromDate.animation(),
                                in: ...Date().nextNYearDate(2),
                                displayedComponents: .date
                            ) {
                                Text("Select a date").fontWeight(.medium)
                            }
                            .padding(.bottom, 4.0)
                        case .monthAndYear:
                            MonthYearView(selectedDate: $filterConfig.fromDate.animation())
                        }
                    }
                }
            }
        }
    }
}

private struct SummaryScreenFilterHeader: View {
    @EnvironmentObject private var config: SummaryFilterConfig
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(config.dateFilterType == DateFilterType.day ?
                    config.getStartDate().mediumDateString() :
                    config.getStartDate().monthAndYearString(.wide))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Chevron()
                    .rotationEffect(.degrees(config.filterExpanded ? 90.0 : 0), anchor: .center)
                    .animation(.linear(duration: 0.2), value: config.filterExpanded)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation { config.filterExpanded.toggle() }
            }
        }
    }
}
