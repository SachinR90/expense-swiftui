//
//  Chevron.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 10/11/22.
//

import SwiftUI

struct Chevron: View {
    var color: Color = .secondary
    var body: some View {
        Image(systemName: "chevron.right")
            .foregroundColor(color)
            .font(.body)
            .fixedSize()
    }
}

struct Chevron_Previews: PreviewProvider {
    static var previews: some View {
        Chevron()
    }
}
