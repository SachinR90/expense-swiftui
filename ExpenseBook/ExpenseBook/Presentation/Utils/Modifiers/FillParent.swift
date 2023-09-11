//
//  FillParent.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 20/10/22.
//

import SwiftUI

struct FillParent: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(minWidth: 0,
                      maxWidth: .infinity,
                      minHeight: 0,
                      maxHeight: .infinity,
                      alignment: .topLeading)
    }
}
