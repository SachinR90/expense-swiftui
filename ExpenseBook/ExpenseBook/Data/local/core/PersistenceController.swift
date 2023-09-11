//
//  DataController.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 23/09/22.
//

import CoreData
import Foundation
final class PersistenceController {
    private init() {
        container = NSPersistentContainer(name: "expense-book")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }

    // Storage for Core Data
    let container: NSPersistentContainer

    // A singleton for our entire app to use
    static let shared: PersistenceController = .init()

    // A test configuration for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController()
        // TODO: add some mock data to container here.
        return controller
    }()

    lazy var viewContext: NSManagedObjectContext = {
        let context = container.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()

    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
            }
        }
    }

    func performInBackground(block: @escaping (NSManagedObjectContext) -> Void) {
        container.performBackgroundTask { [weak self] context in
            guard let self = self else { return }
            block(context)
            self.save()
        }
    }

    func deleteInBackground(objectID: NSManagedObjectID) {
        container.performBackgroundTask { [weak self] context in
            guard let self = self else { return }
            do {
                context.delete(context.object(with: objectID))
                if context.hasChanges {
                    try context.save()
                }
                self.save()
            } catch {
                fatalError("Something went wrong: \(error.localizedDescription)")
            }
        }
    }
}
