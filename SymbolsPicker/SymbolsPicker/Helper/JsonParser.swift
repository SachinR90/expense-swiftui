//
//  JsonParser.swift
//  SymbolsPicker
//
//  Created by Sachin Rao on 10/10/22.
//

import CoreData
final class JsonParser{
    static let KEY_IS_LOADED = "KEY_IS_LOADED"
    private let controller:SymbolsPickerController = SymbolsPickerController.shared
    static let shared:JsonParser = JsonParser()
    private init(){}
    
    func initiateParsing(){
        if(!UserDefaults.standard.bool(forKey: JsonParser.KEY_IS_LOADED)){
            let jsonFile = Bundle(for: type(of: self)).path(forResource: "CategorySymbol", ofType: "json")
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile!), options: .mappedIfSafe) else{
                fatalError("Resource not found")
            }
            let decoder = JSONDecoder()
            var arrData:[CategorySymbols] = []
            do{
                arrData = try decoder.decode([CategorySymbols].self, from: data)
            }catch{
                print(error.localizedDescription)
            }
            let coreDataHelper = CoreDataHelper()
            controller.container.performBackgroundTask { context in
                var categoryDictionary:[Int:CDPickerCategory] = [:]
                var symbolDictionary:[Int:CDPickerSymbol] = [:]

                for item in arrData{
                    let cdCategory = categoryDictionary[item.categoryId, default: coreDataHelper.create(category: item, context)]
                    let cdSymbol = symbolDictionary[item.symbolId, default:coreDataHelper.create(symbol: item, context)]
                    let catSymbols:NSMutableOrderedSet = (cdCategory.symbols?.mutableCopy() as? NSMutableOrderedSet) ?? NSMutableOrderedSet(array: [])
                    catSymbols.add(cdSymbol)
                    cdCategory.symbols = catSymbols
                    categoryDictionary[item.categoryId] = cdCategory
                    symbolDictionary[item.symbolId] = cdSymbol
                }
                _ = coreDataHelper.createCategory(id: 0, name: "All", context)
                if context.hasChanges {
                    do {
                        try context.save()
                    } catch {
                        print(error)
                    }
                }
                UserDefaults.standard.set(true, forKey: JsonParser.KEY_IS_LOADED)
                UserDefaults.standard.synchronize()
                debugPrint("Fininshed fetching symbols...")
            }
        }
    }
}
