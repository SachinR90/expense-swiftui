//
//  SymbolPicker.swift
//  SymbolsPicker
//
//  Created by Sachin Rao on 12/10/22.
//

import SwiftUI
public struct SymbolPicker<Content>:View where Content:View{
    var label: () -> Content?
    @Binding var symbol:String
    @Binding var symbolColor:Color
    @State var showSheet:Bool = false
    let controller = SymbolsPickerController.shared
    public init(symbol:Binding<String>, symbolColor:Binding<Color>,@ViewBuilder _ content:@escaping () -> Content? = {nil}){
        self._symbol = symbol
        self._symbolColor = symbolColor
        self.label = content
    }
    public var body: some View{
        HStack{
            label() ?? defaultContent()
            Spacer()
            if let selectedSymbol = symbol.safeSystemImage(){
                Image(systemName: selectedSymbol)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(symbolColor)
                    .frame(width: 28,height: 28)
            }
        }
        .contentShape(Rectangle())
        .padding(.vertical,16)
            .onTapGesture {
                showSheet.toggle()
            }.sheet(isPresented: $showSheet,onDismiss:{showSheet = false}) {
                SymbolsViewForm(selectedSymbol: $symbol,
                                symbolColor: $symbolColor)
            }.environment(\.managedObjectContext, controller.container.viewContext)
    }
    
    private func defaultContent() -> Content{
        Text("Select a symbol ").fontWeight(.medium) as! Content
    }
}
extension SymbolPicker where Content == Text{
    public init(symbol:Binding<String>, symbolColor:Binding<Color>){
        self.init(symbol: symbol, symbolColor:symbolColor) {
            Text("Select a symbol ").fontWeight(.medium)
        }
    }
}

struct SymbolPicker_Previews:PreviewProvider{
    @State static var symbol:String = "Hello"
    @State static var symbolColor:Color = .black
    static var previews: some View {
        SymbolPicker(symbol:SymbolPicker_Previews.$symbol,
                     symbolColor: SymbolPicker_Previews.$symbolColor)
        .previewLayout(.sizeThatFits)
    }
}
