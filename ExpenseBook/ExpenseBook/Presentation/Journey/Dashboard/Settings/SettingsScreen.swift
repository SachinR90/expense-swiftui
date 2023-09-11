//
//  SettingsView.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 05/10/22.
//

import SwiftUI
struct SettingScreen: View {
    let persistentController: PersistenceController = .shared
    var body: some View {
        NavigationView {
            Form {
                NavigationLink {
                    CategoryScreen()
                } label: {
                    Label(
                        title: { Text("Categories") },
                        icon: { Image(systemName: "filemenu.and.selection") }
                    )
                }
            }
            .navigationTitle(Text("Settings"))
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}
