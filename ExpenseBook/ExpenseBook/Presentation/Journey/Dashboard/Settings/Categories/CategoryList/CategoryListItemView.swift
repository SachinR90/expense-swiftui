//
//  CategoryListItemView.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 05/11/22.
//

import SwiftUI

struct CategoryListItemView: View {
    var category: CDCategory
    var iconSize: CGFloat = 16.0
    var body: some View {
        HStack {
            Image(systemName: category.symbol.isEmptyOrNil ? "exclamationmark.triangle" : category.symbol!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: iconSize, height: iconSize)
                .foregroundColor(category.color.isEmptyOrNil ? Color.black : category.color!.toColor()!)
            Text(category.title ?? "")
                .font(.callout)
                .foregroundColor(.black)
            Spacer()
            Chevron()
        }
        .padding()
        .frame(minHeight: 36)
    }
}
