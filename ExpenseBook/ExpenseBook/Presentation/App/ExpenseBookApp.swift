//
//  ExpenseBookApp.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 26/08/22.
//

import SwiftUI
import SymbolsPicker

@main
struct ExpenseBookApp: App {
    @Environment(\.scenePhase) private var scenePhase
    let persistenceController: PersistenceController
    let pickerUtils: SymbolsPickerHelper
    init() {
        persistenceController = PersistenceController.shared
        pickerUtils = SymbolsPickerHelper()
        pickerUtils.loadSymbols()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
