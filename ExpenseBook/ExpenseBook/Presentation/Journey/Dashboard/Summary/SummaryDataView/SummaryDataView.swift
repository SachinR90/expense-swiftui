//
//  SummaryDataView.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 18/11/22.
//

import SwiftUI

struct SummaryDataView: View {
    @SectionedFetchRequest<String?, CDExpense>
    private var categoriedExpenses: SectionedFetchResults<String?, CDExpense>

    @FetchRequest(entity: CDExpense.entity(), sortDescriptors: [])
    private var noCategoryExpenses: FetchedResults<CDExpense>

    @Environment(\.managedObjectContext)
    private var context

    @EnvironmentObject
    private var config: SummaryFilterConfig

    @State var uniq = UUID()
    var body: some View {
        if noCategoryExpenses.isEmpty && categoriedExpenses.isEmpty {
            EmptyDataView()
                .padding(.all, 0)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else {
            VStack {
                SummaryListView(expensesWithoutCategory: noCategoryExpenses,
                                categoriedExpenses: categoriedExpenses)
            }
            .background(Color.white)
            .frame(maxHeight: .infinity)
        }
    }
}

extension SummaryDataView {
    init(startDate: Date? = nil, endDate: Date? = nil) {
        _noCategoryExpenses = SummaryDataView
            .requestForNoCategoriedExpenses(startDate: startDate,
                                            endDate: endDate)
        _categoriedExpenses = SummaryDataView
            .requestForCategoriedExpenses(startDate: startDate,
                                          endDate: endDate)
    }

    private static func requestForCategoriedExpenses(startDate: Date? = nil,
                                                     endDate: Date? = nil) -> SectionedFetchRequest<String?, CDExpense> {
        let request = CDExpense.fetchRequest()
        let dateSort = NSSortDescriptor(key: #keyPath(CDExpense.date), ascending: false)
        let categorySort = NSSortDescriptor(key: #keyPath(CDExpense.category.title), ascending: true)
        request.sortDescriptors = [categorySort, dateSort]

        let categoryNotNullPredicate = NSPredicate(format: "category != nil")
        if let start = startDate as? NSDate,
           let end = endDate as? NSDate {
            let datePredicate = NSPredicate(format: "date >= %@ AND date <=%@ ", start, end)
            let compoundPredicate =
                NSCompoundPredicate(andPredicateWithSubpredicates: [categoryNotNullPredicate,
                                                                    datePredicate])
            request.predicate = compoundPredicate
        } else {
            request.predicate = categoryNotNullPredicate
        }
        return SectionedFetchRequest<String?, CDExpense>(fetchRequest: request, sectionIdentifier: \.category?.title)
    }

    private static func requestForNoCategoriedExpenses(startDate: Date? = nil,
                                                       endDate: Date? = nil) -> FetchRequest<CDExpense> {
        let categoryRequest = CDExpense.fetchRequest()
        let categorySort = NSSortDescriptor(key: #keyPath(CDExpense.date),
                                            ascending: false)
        categoryRequest.sortDescriptors = [categorySort]

        let categoryNotNullPredicate = NSPredicate(format: "category == nil")
        if let start = startDate as? NSDate,
           let end = endDate as? NSDate {
            let datePredicate = NSPredicate(format: "date >= %@ AND date <= %@ ", start, end)
            let compoundPredicate =
                NSCompoundPredicate(andPredicateWithSubpredicates: [datePredicate,
                                                                    categoryNotNullPredicate])
            categoryRequest.predicate = compoundPredicate
        } else {
            categoryRequest.predicate = categoryNotNullPredicate
        }
        return FetchRequest<CDExpense>(fetchRequest: categoryRequest)
    }
}
