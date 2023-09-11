//
//  CategoryScreenViewModel.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 05/11/22.
//

import CoreData
import SwiftUI
class CategoryFormViewModel: ObservableObject {
    var cdCategory: CDCategory?
    private let persistentController: PersistenceController = .shared
    @Published var title: String = ""
    @Published var symbol: String = ""
    @Published var color: Color = .black

    final func setCategory(category: CDCategory) {
        cdCategory = category
        title = cdCategory?.title ?? ""
        symbol = cdCategory?.symbol ?? ""
        color = cdCategory?.color?.toColor() ?? Color.black
    }

    final func saveCategory() {
        persistentController.performInBackground { [weak self] context in
            guard let self = self else { return }

            let createdDate = self.cdCategory?.createdDate ?? Date()
            let modifiedDate = Date()

            // relationships cannot be created with 2 different NSManangedContext.
            // hence we bring CDCategory(created in another context) in CDExpense's ManagedContext in following code
            if let category = self.cdCategory,
               let categoryMoc = category.managedObjectContext,
               let sameContextCategory = categoryMoc.object(with: category.objectID) as? CDCategory {
                self.cdCategory = sameContextCategory
            } else {
                self.cdCategory = CDCategory(context: context)
            }

            self.cdCategory!.title = self.title
            self.cdCategory!.symbol = self.symbol
            self.cdCategory!.color = self.color.toHexString() ?? ""
            self.cdCategory!.createdDate = createdDate
            self.cdCategory!.modifiedDate = modifiedDate

            if let expenses = self.cdCategory?.expenses?.allObjects as? [CDExpense], !expenses.isEmpty {
                for expense in expenses {
                    expense.modifiedDate = modifiedDate
                }
            }
            if context.hasChanges {
                do {
                    try context.save()
                    try self.cdCategory!.managedObjectContext?.save()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
