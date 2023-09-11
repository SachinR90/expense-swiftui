//
//  ExpenseItem.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 20/09/22.
//

import CoreData
enum ExpenseType: Int, CaseIterable {
    case credit = 0
    case debit = 1

    var description: String {
        switch self {
        case .debit:
            return "Debit"
        case .credit:
            return "Credit"
        }
    }
}

struct ExpenseEntity {
    var id: Int = -1
    var title: String = ""
    var amount: Double = 0.0
    var date: Date = .init().defaultTime()
    var createdDate = Date().defaultTime()
    var modifiedDate = Date().defaultTime()
    var category: CategoryEntity = .init(id: 1)
    var type: ExpenseType = .debit
}

extension ExpenseEntity: Identifiable {}
extension ExpenseEntity {
    func toCDEntitiy(context: NSManagedObjectContext) -> CDExpense {
        let entity = CDExpense(context: context)

        return entity
    }
}
