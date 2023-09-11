//
//  SearchBar.swift
//  SymbolsPicker
//
//  Created by Sachin Rao on 14/10/22.
//

import Combine
import SwiftUI

struct SearchBar:View{
   @Binding var searchText:String
   @Binding var isEditing:Bool
   var onTextFieldCancel:(() -> Void)?
   var body: some View{
       HStack {
           TextField("Search symbol...", text: $searchText)
               .padding(7)
               .padding(.horizontal, 25)
               .background(Color(.systemGray6))
               .cornerRadius(8)
               .padding(.horizontal, 10)
               .autocorrectionDisabled()
               .textInputAutocapitalization(.never)
               .onTapGesture {
                   withAnimation{
                       self.isEditing = true
                   }
               }
           if isEditing {
               Button(action: {
                   withAnimation {
                       self.isEditing = false
                       self.searchText = ""
                       onTextFieldCancel?()
                       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                   }
               }) {
                   Text("Cancel")
               }
               .padding(.trailing, 10)
               .transition(.move(edge: .trailing))
           }
       }.overlay(
           HStack {
               Image(systemName: "magnifyingglass")
                   .foregroundColor(.gray)
                   .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                   .padding(.leading, 14)
               
               Image(systemName: "multiply.circle.fill")
                   .resizable()
                   .scaledToFit()
                   .frame(width: 18,height: 18)
                   .foregroundColor(.secondary)
                   .opacity(searchText.isEmpty ? 0 : 1)
                   .onTapGesture { withAnimation{self.searchText = "" }}
                   .padding(.trailing,90)
           }
       )
   }
}

extension SearchBar{
   func onCanceldTapped(_ action: (() -> Void)?)-> SearchBar{
       var view = self
       view.onTextFieldCancel = action
       return view
   }
}

final class DebounceObject: ObservableObject {
    @Published var text: String = ""
    @Published var debouncedText: String = ""
    private var bag = Set<AnyCancellable>()

    public init(dueTime: TimeInterval = 0.5) {
        $text
            .map{$0.trimmingCharacters(in: .whitespacesAndNewlines)}
            .filter{$0.count < 70}
            .removeDuplicates()
            .debounce(for: .seconds(dueTime), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.debouncedText = value
            })
            .store(in: &bag)
    }
}
