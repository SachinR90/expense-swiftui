//
//  CDExpense+Extensions.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 21/10/22.
//

import CoreData
extension CDExpense {
    var type: ExpenseType {
        expenseType == 0 ? .credit : .debit
    }
}
