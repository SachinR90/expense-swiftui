//
//  GridItemView.swift
//  SymbolsPicker
//
//  Created by Sachin Rao on 14/10/22.
//

import SwiftUI

struct GridSectionHeader:View{
    var count:Int
    var body: some View{
        Rectangle()
            .fill(Color.white)
            .frame(maxWidth: .infinity)
            .frame(height: 32)
            .overlay(
                Text("Count: \(count)")
                    .font(.footnote).fontWeight(.light)
                    .padding(.horizontal,8)
                ,alignment: .leading)
    }
}

struct SymbolGridItem:View{
    var symbolName:String
    @Binding var symbol:String
    @Binding var symbolColor:Color
    var proxy:GeometryProxy
    @State var animate = false
    var body: some View{
        VStack(alignment: .center){
            Image(systemName: symbolName.safeSystemImage() ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: proxy.size.width / 4 - 32, height: proxy.size.width / 4 - 32)
                .foregroundColor(symbolColor)
                .onTapGesture {
                    withAnimation {
                        symbol = symbolName
                    }
                    animate.toggle()
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.3)) {
                        animate.toggle()
                    }
                }
            Text(symbolName)
                .font(.footnote)
                .fontWeight(.light)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity,minHeight: 40, maxHeight: 40)
            
        }.scaleEffect(animate ? 0.85 : 1.0)
    }
}
