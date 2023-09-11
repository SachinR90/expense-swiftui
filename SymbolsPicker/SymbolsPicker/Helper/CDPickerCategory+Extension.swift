//
//  CDPickerCategory+Extension.swift
//  SymbolsPicker
//
//  Created by Sachin Rao on 14/10/22.
//

import Foundation
extension CDPickerCategory{
    var symbolList:[CDPickerSymbol]{
        (symbols?.array as? [CDPickerSymbol]) ?? []
    }
}
