//
//  PieChart.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 16/11/22.
//

import Charts
import SwiftUI

struct PieChart: UIViewRepresentable {
    let pieChartData: PieChartData
    private let pieChart = PieChartView()

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> PieChartView {
        pieChart.delegate = context.coordinator
        pieChart.noDataText = "No Data"
        pieChart.holeRadiusPercent = 0.0
        pieChart.legend.enabled = false
        pieChart.drawEntryLabelsEnabled = true

        pieChart.usePercentValuesEnabled = true
        pieChart.sliceTextDrawingThreshold = 30

        return pieChart
    }

    func updateUIView(_ uiView: PieChartView, context _: Context) {
        uiView.data = pieChartData
        uiView.notifyDataSetChanged()
    }

    class Coordinator: NSObject, ChartViewDelegate {
        let parent: PieChart

        init(parent: PieChart) {
            self.parent = parent
        }
    }
}
