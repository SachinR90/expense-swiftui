//
//  ExpenseFormViewModel.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 15/10/22.
//

import CoreData
import SwiftUI

class ExpenseFormViewModel: ObservableObject {
    public init() {}

    init(expenseEntity: CDExpense?) {
        if expenseEntity != nil {
            expenseToEdit = expenseEntity
            setExpense(expense: expenseToEdit!)
        }
    }

    @Published var title: String = ""
    @Published var description: String = ""
    @Published var amount: Double = 0.0
    @Published var date: Date = .init()
    @Published var expenseType: ExpenseType = .debit
    @Published var category: CDCategory?

    var expenseToEdit: CDExpense?

    private let persistentController = PersistenceController.shared

    var isValidEntry: Bool {
        var isValid = true
        if title.isEmpty || title.count > 30 {
            isValid = false
        }

        if amount <= 0 || amount > 9_999_999_999 {
            isValid = false
        }

        return isValid
    }

    func setExpense(expense: CDExpense) {
        expenseToEdit = expense
        title = expenseToEdit?.title ?? ""
        amount = expenseToEdit?.amount ?? 0.0
        date = (expenseToEdit?.date ?? Date())!.defaultTime()
        expenseType = expenseToEdit?.type ?? .debit
        category = expenseToEdit?.category
        description = expenseToEdit?.details ?? ""
    }

    func saveExpense() {
        persistentController.performInBackground { [weak self] context in
            guard let self = self else { return }
            let createdDate = self.expenseToEdit?.createdDate ?? Date()
            let modifiedDate = Date()

            // relationships cannot be created with 2 different NSManangedContext.
            // hence we bring CDCategory(created in another context) in CDExpense's ManagedContext in following code
            if let cdExpense = self.expenseToEdit,
               let mocContext = cdExpense.managedObjectContext,
               let sameContextExpense = mocContext.object(with: cdExpense.objectID) as? CDExpense {
                self.expenseToEdit = sameContextExpense
            } else {
                self.expenseToEdit = CDExpense(context: context)
            }

            self.expenseToEdit!.title = self.title
            self.expenseToEdit!.expenseType = Int16(self.expenseType.rawValue)
            self.expenseToEdit!.date = self.date.defaultTime()
            self.expenseToEdit!.amount = self.amount

            // relationships cannot be created with 2 different NSManangedContext.
            // hence we bring CDCategory(created in another context) in CDExpense's ManagedContext in following code
            if let category = self.category,
               let mocContext = self.expenseToEdit!.managedObjectContext,
               let sameContextCategory = mocContext.object(with: category.objectID) as? CDCategory {
                self.expenseToEdit!.category = sameContextCategory
            } else {
                self.expenseToEdit!.category = nil
            }

            self.expenseToEdit!.details = self.description
            self.expenseToEdit!.createdDate = createdDate
            self.expenseToEdit!.modifiedDate = modifiedDate
            if context.hasChanges {
                do {
                    try context.save()
                    try self.expenseToEdit!.managedObjectContext?.save()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }

    var hintText: String {
        if expenseToEdit == nil && amount == 0 {
            return ""
        }
        let currencySymbol = Locale.autoupdatingCurrent.currencySymbol ?? ""
        let spelledOut = amount.toLocalCurrency(decimalsDigits: 0, style: .spellOut).capitalizedFirst
        return currencySymbol + spelledOut
    }
}
