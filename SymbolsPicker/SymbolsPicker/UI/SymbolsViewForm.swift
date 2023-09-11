//
//  SymbolsViewForm.swift
//  SymbolsPicker
//
//  Created by Sachin Rao on 12/10/22.
//

import SwiftUI
import Combine


struct SymbolsViewForm:View{
    let coreDataHelper:CoreDataHelper = CoreDataHelper()
    
    @Binding var selectedSymbol:String
    @Binding var symbolColor:Color
    
    @State private var categories:[CDPickerCategory] = []
    @State private var symbols:[CDPickerSymbol] = []
    @State private var scrollViewID = false
    @State private var symbol:String = ""
    @State private var appeared = false
    @State private var isTagListVisible = true
    @State private var isEditing = false
    @StateObject private var debounceObject = DebounceObject()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    let columns = [
        GridItem(.adaptive(minimum: 75,maximum: 150))
    ]
    
    var body: some View{
        NavigationView{
            VStack(alignment: .leading){
                SearchBar(searchText: $debounceObject.text, isEditing: $isEditing)
                    .onCanceldTapped(onTextFieldCancel)
                if(!isEditing){
                    TagList(tagList: categories.map{
                        TagItem(title: $0.name ?? "",id: Int($0.categoryId))
                    })
                    .onItemSelected(onTagSelection)
                    .padding(8)
                    Spacer()
                        .frame(height: 4)
                }
                GeometryReader{ geometry in
                    ScrollView(.vertical){
                        LazyVGrid(columns: columns,spacing: 24,pinnedViews: [.sectionHeaders]) {
                            Section(header: GridSectionHeader(count: symbols.count)){
                                ForEach(symbols, id: \.self) { item in
                                    SymbolGridItem(symbolName: item.name ?? "", symbol: $symbol, symbolColor: $symbolColor, proxy: geometry)
                                }
                            }
                        }
                    }.id(scrollViewID)
                }
            }
            .navigationBarItems(
                leading: Button(action:self.onCancelTapped){Text("Cancel")},
                trailing: Button(action: self.onSaveTapped){Text("Done")}
            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    if (symbol.isEmpty){
                        Text("Select a Symbol").font(.headline)
                    }
                    else{
                        HStack(alignment: .center){
                            Text("Selected Symbol").font(.headline)
                            Image(systemName: symbol)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20,height: 20)
                                .foregroundColor(symbolColor)
                        }
                    }
                }
            }
            .interactiveDismissDisabled()
        }.onAppear{
            if !appeared {
                symbol = selectedSymbol
                categories = coreDataHelper.fetchCategories(context: managedObjectContext)
                symbols = coreDataHelper.fetchAllSymbols(context: managedObjectContext)
                appeared = false
            }
        }.onChange(of: debounceObject.debouncedText) { newValue in
            print("Debounced \(debounceObject.debouncedText), newValue:\(newValue)")
            if(debounceObject.text.isEmpty || newValue.isEmpty){
                symbols = coreDataHelper.fetchAllSymbols(context: managedObjectContext)
            }else{
                symbols = coreDataHelper.fetchSymbols(of:newValue.lowercased(), context: managedObjectContext)
            }
        }
    }
    
    private func onCancelTapped(){
        presentationMode.wrappedValue.dismiss()
    }
    
    private func onSaveTapped(){
        presentationMode.wrappedValue.dismiss()
        selectedSymbol = symbol
    }
    
    private func onTagSelection(selectedId:Int){
        withAnimation {
            let selectedCategory = categories.first(where: {$0.categoryId == selectedId})!
            symbols = []
            if(selectedCategory.name == "All"){
                symbols = coreDataHelper.fetchAllSymbols(context: managedObjectContext)
            }else{
                symbols = selectedCategory.symbolList
            }
            scrollViewID.toggle()
        }
    }
    
    private func onTextFieldCancel(){
        symbols = coreDataHelper.fetchSymbols(of:debounceObject.debouncedText.lowercased(), context: managedObjectContext)
    }
}
