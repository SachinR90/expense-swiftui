//
//  SummaryDataListHeaderView.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 07/12/22.
//

import SwiftUI

struct SummaryListHeaderView: View {
    var title: String
    var subTitle: String
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(.black)
            Spacer()
            Text(subTitle)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(.black)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.clear)
    }
}

struct SummaryListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryListHeaderView(title: "Hello World", subTitle: "$150000")
            .previewLayout(.sizeThatFits)
    }
}
