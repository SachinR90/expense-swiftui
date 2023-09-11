//
//  SideMenuState.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 20/09/22.
//

import Foundation
import SwiftUI

final class SideMenuState: ObservableObject {
    @Published var isOpen: Bool = false
}
