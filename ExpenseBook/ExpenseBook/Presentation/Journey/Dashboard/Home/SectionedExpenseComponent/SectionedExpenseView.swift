//
//  SectionedExpenseList.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 19/10/22.
//

import SwiftUI
struct SectionedExpenseView: View {
    @Environment(\.managedObjectContext) private var context

    @SectionedFetchRequest<Date?, CDExpense>
    private var items: SectionedFetchResults<Date?, CDExpense>
    private var action: ((CDExpense) -> Void)?
    private var totalSum: Double {
        items.reduce(0.0) { partialResult, section in
            section.reduce(partialResult) {
                $1.type == .debit ? $0 + $1.amount : $0 - $1.amount
            }
        }
    }

    private var totalReceived: Double {
        items.reduce(0.0) { partialResult, section in
            section.reduce(partialResult) {
                $1.type == .credit ? $0 + $1.amount : $0 + 0
            }
        }
    }

    private var totalPaid: Double {
        items.reduce(0.0) { partialResult, section in
            section.reduce(partialResult) {
                $1.type == .debit ? $0 + $1.amount : $0 + 0
            }
        }
    }

    var body: some View {
        if items.isEmpty {
            EmptyDataView(title: "No data found.")
                .padding(.all, 0)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else {
            SectionedExpenseHeaderView(totalRecived: totalReceived, totalPaid: totalPaid)
                .padding(.bottom, 4.0)
            List {
                ForEach(items) { section in
                    Section {
                        ForEach(section, id: \.objectID) { expense in
                            SectionedExpenseListItemView(expense: expense)
                                .id(expense.modifiedDate)
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button(role: .destructive) {
                                        performDelete(expense: expense)
                                    } label: {
                                        Label("Delete", systemImage: "trash.fill")
                                    }
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button {
                                        self.action?(expense)
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                    .tint(.indigo)
                                }
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                        }
                    } header: {
                        SectionedExpenseListHeaderView(title: "\(section.id?.mediumDateString() ?? "")")
                    }
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
        }
    }

    private func performDelete(expense: CDExpense) {
        withAnimation {
            do {
                context.delete(expense)
                if context.hasChanges {
                    try context.save()
                }
            } catch {
                fatalError("Something went wrong: \(error.localizedDescription)")
            }
        }
    }
}

extension SectionedExpenseView {
    init(startDate: Date? = nil, endDate: Date? = nil) {
        let request = CDExpense.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(CDExpense.date), ascending: false)
        request.sortDescriptors = [sort]
        if let date = startDate {
            let start = date
            let end = endDate!
            request.predicate = NSPredicate(format: "date >= %@ AND date <=%@ ", start as NSDate, end as NSDate)
        }
        _items = SectionedFetchRequest<Date?, CDExpense>(fetchRequest: request, sectionIdentifier: \.date)
    }
}

extension SectionedExpenseView {
    func onEntitySelected(_ action: ((CDExpense) -> Void)?) -> SectionedExpenseView {
        var view = self
        view.action = action
        return view
    }
}
