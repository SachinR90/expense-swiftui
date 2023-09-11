//
//  Optionals+Extensions.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 19/10/22.
//

import SwiftUI

extension Binding {
    func bind<T>(_ defaultValue: T) -> Binding<T> where Value == T? {
        Binding<T>(
            get: { self.wrappedValue ?? defaultValue },
            set: { self.wrappedValue = $0 }
        )
    }

    func onChange(_ completion: @escaping (Value) -> Void) -> Binding<Value> {
        .init(get: { self.wrappedValue }, set: { self.wrappedValue = $0; completion($0) })
    }
}
