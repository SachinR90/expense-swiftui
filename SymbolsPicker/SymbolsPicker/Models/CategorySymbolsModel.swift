//
//  CategorySymbolsModel.swift
//  SymbolsPicker
//
//  Created by Sachin Rao on 10/10/22.
//

import Foundation
struct CategorySymbols{
    var categoryId:Int
    var categoryName:String
    var symbolId:Int
    var symbolName:String
}

extension CategorySymbols:Codable{}
