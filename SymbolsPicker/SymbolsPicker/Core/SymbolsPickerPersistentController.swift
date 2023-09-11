//
//  SymbolsPickerPersistentController.swift
//  SymbolsPicker
//
//  Created by Sachin Rao on 10/10/22.
//

import CoreData
final class SymbolsPickerController{
    
    // A singleton for our entire app to use
    static let shared:SymbolsPickerController = SymbolsPickerController()
    
    private let identifier = "com.example.SymbolsPicker"
    private let model = "SymbolPickerModel"
    
    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    private init(){}
    
    // Storage for Core Data
    lazy var container: NSPersistentContainer = {
        let bundle = Bundle(identifier: self.identifier)
        let url = bundle!.url(forResource: self.model, withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: url)
        let persistentContainer = NSPersistentContainer(name: self.model,
                                                        managedObjectModel: managedObjectModel!)
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        return persistentContainer
    }()

    func save(){
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
