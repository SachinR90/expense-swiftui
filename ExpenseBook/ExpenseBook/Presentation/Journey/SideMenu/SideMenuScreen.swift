//
//  SidebarMenuView.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 26/08/22.
//

import Foundation
import SwiftUI

struct SideMenuScreen: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Profile")
                    .foregroundColor(.gray)
                    .font(.headline)
            }.padding(.top, 100)
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Messages")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            HStack {
                Image(systemName: "gear")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Settings")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            Spacer()
        }.padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
    }
}
