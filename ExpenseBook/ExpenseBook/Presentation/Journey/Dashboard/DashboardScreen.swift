//
//  DashboardVIew.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 26/08/22.
//

import Foundation
import SwiftUI
enum TabScreens {
    case home
    case summary
    case investments
    case settings
}

struct DashboardScreen: View {
    @State var selectedTab: TabScreens = .home
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeScreen()
                .tabItem {
                    Label { Text("Home") } icon: { Image(systemName: "house") }
                    Text("Home")
                }
                .tag(TabScreens.home)

            SummaryScreen()
                .tabItem {
                    Label { Text("Summary") } icon: { Image(systemName: "list.bullet.rectangle.portrait") }
                    Text("Summary")
                }
                .tag(TabScreens.summary)

            InvestmentScreen()
                .tabItem {
                    Label { Text("Investment") } icon: { Image(systemName: "bag") }
                    Text("Investment")
                }
                .tag(TabScreens.investments)

            SettingScreen()
                .tabItem {
                    Label { Text("Settings") } icon: { Image(systemName: "gearshape") }
                    Text("Settings")
                }
                .tag(TabScreens.settings)
        }
        .animation(.easeInOut(duration: 1000), value: selectedTab)
        .onAppear {
            // correct the transparency bug for Tab bars
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}
