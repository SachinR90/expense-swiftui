//
//  SummaryChartView.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 16/11/22.
//

import Charts
import SwiftUI

struct SummaryGraphView: View {
    @State private var data: [PieChartDataEntry] = [
        PieChartDataEntry(value: 354, label: "Rewe", icon: NSUIImage(systemName: "cart"), data: "rewe"),
        PieChartDataEntry(value: 261, label: "Lidl", icon: NSUIImage(systemName: "cart"), data: "rewe"),
        PieChartDataEntry(value: 117, label: "Langer Name", icon: NSUIImage(systemName: "cart"), data: "rewe"),
        PieChartDataEntry(value: 14, label: "Aldi", icon: NSUIImage(systemName: "cart"), data: "rewe")
    ]
    private func getPieData() -> PieChartData {
        let dataSet = PieChartDataSet(entries: data)
        dataSet.label = "Categories"
        dataSet.colors = ChartColorTemplates.vordiplom()
        dataSet.valueColors = [.black]

        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1
        formatter.percentSymbol = " %"
        dataSet.valueFormatter = DefaultValueFormatter(formatter: formatter)
        let data = PieChartData(dataSet: dataSet)
        return data
    }

    var body: some View {
        GeometryReader { geometry in
            PieChart(pieChartData: getPieData()).frame(height: geometry.size.height)
        }
    }
}
