//
//  String+Extensions.swift
//  SymbolsPicker
//
//  Created by Sachin Rao on 14/10/22.
//

import SwiftUI

extension String{
    func safeSystemImage() -> String? {
        if UIImage(systemName: self) != nil {
            return self
        }
        return nil
    }
}
