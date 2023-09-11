//
//  HomeListHeader.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 19/10/22.
//

import SwiftUI
/* The font-weight values from thinnest to thickest are ultralight, thin, light,
 regular, medium, semibold, bold, heavy, and black.

 .largeTitle     34.0    SFUIDisplay
 .title1         28.0    SFUIDisplay (-Light ≤ iOS 10)
 .title2         22.0    SFUIDisplay
 .title3         20.0    SFUIDisplay
 .headline       17.0    SFUIText-Semibold
 .subheadline    15.0    SFUIText
 .body           17.0    SFUIText
 .callout        16.0    SFUIText
 .footnote       13.0    SFUIText
 .caption1       12.0    SFUIText
 .caption2       11.0    SFUIText

 */
struct HomeFiltersView: View {
    @State private var proxyDateForPicker: Date?
    @EnvironmentObject private var config: DateFilterConfig

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(config.getStartDate().monthAndYearString(.wide))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading, 16)
                Spacer()
                Chevron()
                    .rotationEffect(.degrees(config.filterExpanded ? 90.0 : 0), anchor: .center)
                    .animation(.linear(duration: 0.2), value: config.filterExpanded)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation { config.filterExpanded.toggle() }
            }
            if config.filterExpanded {
                MonthYearView(selectedDate: $config.fromDate)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.trailing, 16)
    }
}
