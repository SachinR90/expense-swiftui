//
//  CDCategory+Extensions.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 18/11/22.
//

import CoreData
extension CDCategory {
    var totalSum: Double {
        expenses?.reduce(0.0) { result, expense in
            guard let expense = expense as? CDExpense else {
                return result
            }
            return expense.type == .debit ? result + expense.amount : result - expense.amount
        } ?? 0.0
    }

    private var totalReceived: Double {
        expenses?.reduce(0.0) { result, expense in
            guard let expense = expense as? CDExpense else {
                return result
            }
            return expense.type == .credit ? result + expense.amount : 0.0
        } ?? 0.0
    }

    private var totalPaid: Double {
        expenses?.reduce(0.0) { result, expense in
            guard let expense = expense as? CDExpense else {
                return result
            }
            return expense.type == .debit ? result + expense.amount : 0.0
        } ?? 0.0
    }
}
