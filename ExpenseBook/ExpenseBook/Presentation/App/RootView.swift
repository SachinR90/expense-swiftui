//
//  MainView.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 26/08/22.
//

import Foundation
import SwiftUI
struct RootView: View {
//    private var drag: _EndedGesture<DragGesture> {
//        DragGesture().onEnded { event in
//            if event.location.x < 200 && abs(event.translation.height) < 50 && abs(event.translation.width) > 50 {
//                withAnimation {
//                    sideMenuState.isOpen = event.translation.width > 0
//                }
//            }
//        }
//    }
//    @StateObject var sideMenuState:SideMenuState = SideMenuState()
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                DashboardScreen()
                    .frame(width: geometry.size.width, height: geometry.size.height)
//                    .offset(x: sideMenuState.isOpen ? geometry.size.width / 1.25 : 0)
//                    .opacity(sideMenuState.isOpen ? 0.5 : 1.0)
//                    .disabled(sideMenuState.isOpen)

//                if self.sideMenuState.isOpen {
//                    SideMenuScreen()
//                        .frame(width: geometry.size.width / 1.25)
//                        .transition(.move(edge: .leading))
//                }
            } // .gesture(drag)
        } // .environmentObject(sideMenuState)
    }
}
