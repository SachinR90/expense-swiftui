//
//  CoreDataHelper.swift
//  SymbolsPicker
//
//  Created by Sachin Rao on 10/10/22.
//

import CoreData

struct CoreDataHelper{
    
    func createCategory(id:Int, name:String,_ context:NSManagedObjectContext) -> CDPickerCategory{
        let cdCategory = CDPickerCategory(context: context)
        cdCategory.categoryId = Int64(id)
        cdCategory.name = name
        cdCategory.symbols = NSMutableOrderedSet(capacity: 0)
        return cdCategory
    }
    func create(category:CategorySymbols,_ context:NSManagedObjectContext) -> CDPickerCategory{
        let cdCategory = CDPickerCategory(context: context)
        cdCategory.categoryId = Int64(category.categoryId)
        cdCategory.name = category.categoryName
        cdCategory.symbols = NSMutableOrderedSet(capacity: 15)
        return cdCategory
    }
    
    func create(symbol:CategorySymbols, _ context:NSManagedObjectContext) -> CDPickerSymbol{
        let cdSymbol = CDPickerSymbol(context: context)
        cdSymbol.symbolId = Int64(symbol.symbolId)
        cdSymbol.name = symbol.symbolName
        cdSymbol.categories = NSMutableOrderedSet(capacity: 26)
        return cdSymbol
    }
    
    func fetchCategories(context:NSManagedObjectContext) -> [CDPickerCategory]{
        let fetchRequest = CDPickerCategory.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(CDPickerCategory.categoryId), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do{
            return try context.fetch(fetchRequest)
        }catch{
            print(error)
        }
        return []
    }
    
    func fetchAllSymbols(context:NSManagedObjectContext) ->[CDPickerSymbol]{
        let fetchRequest = CDPickerSymbol.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(CDPickerSymbol.name),ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do{
            return try context.fetch(fetchRequest)
        }catch{
            print(error)
        }
        return []
    }
    
    func fetchSymbols(of symbol:String, context:NSManagedObjectContext) ->[CDPickerSymbol]{
        if symbol.isEmpty{
            return fetchAllSymbols(context: context)
        }
        let fetchRequest = CDPickerSymbol.fetchRequest()
        let symbolsPredicate = NSPredicate(format: "name CONTAINS[n] %@", symbol)
        let catePredicate = NSPredicate(format: "categories.name CONTAINS[cd] %@", symbol)
        let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [catePredicate,symbolsPredicate])
        fetchRequest.predicate = compoundPredicate
        let sort = NSSortDescriptor(key: #keyPath(CDPickerSymbol.name),ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do{
            let result = try context.fetch(fetchRequest)
            return result
        }catch{
            print(error)
        }
        return []
    }
}
