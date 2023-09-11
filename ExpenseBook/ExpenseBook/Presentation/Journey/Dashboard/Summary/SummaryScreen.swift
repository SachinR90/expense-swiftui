//
//  SummaryScreen.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 05/10/22.
//

import Foundation
import SwiftUI

struct SummaryScreen: View {
    @StateObject
    private var summaryFilter = SummaryFilterConfig()

    var body: some View {
        NavigationView {
            VStack {
                SummaryScreenFilterView()
                SummaryDataView(startDate: summaryFilter.getStartDate(), endDate: summaryFilter.getEndDate()!)
            }
            .padding(.horizontal, 16.0)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    // Text view workaround for SwiftUI bug
                    // Keep toolbar items tappable after dismissing sheet
                    Text(summaryFilter.filterExpanded ? " " : "").hidden()
                    Button {} label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .environmentObject(summaryFilter)
    }
}
