//
//  SymbolsPickerHelper.swift
//  SymbolsPicker
//
//  Created by Sachin Rao on 10/10/22.
//

import Foundation
public class SymbolsPickerHelper{
    public init(){}
    private let parser:JsonParser = JsonParser.shared
    public func loadSymbols(){
        parser.initiateParsing()
    }
    
    public func allCategories() -> [String]{
        let coreHelper = CoreDataHelper()
        return coreHelper
            .fetchCategories(context: SymbolsPickerController.shared.container.viewContext)
            .map {$0.name ?? ""}
            .filter {!$0.isEmpty}
    }
    
    public func isLoaded() -> Bool{
        UserDefaults.standard.bool(forKey: JsonParser.KEY_IS_LOADED)
    }
}
