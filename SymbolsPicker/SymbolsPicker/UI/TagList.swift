//
//  TagList.swift
//  SymbolsPicker
//
//  Created by Sachin Rao on 12/10/22.
//

import SwiftUI

struct TagItem:Hashable{
    var title:String = ""
    var id:Int = 0
}

struct TagList:View{
    var tagList:[TagItem]
    @State var selectedId:Int = 0
    var onSelection:((Int) -> Void)?
    
    var body: some View{
        VStack{
            ScrollView(.horizontal,showsIndicators: false) {
                ScrollViewReader{ scrollView in
                    HStack {
                        ForEach(tagList,id: \.self) { item in
                            Text(item.title)
                                .fontWeight(.medium)
                                .padding(.horizontal,8)
                                .padding(.vertical,4)
                                .foregroundColor(selectedId == item.id ? .white : .black)
                                .background(selectedId == item.id ? .blue.opacity(0.6) : .gray.opacity(0.3))
                                .clipShape(Capsule())
                                .clipped(antialiased: true)
                                .onTapGesture {
                                    withAnimation {
                                        if selectedId == item.id{
                                            return
                                        }
                                        selectedId = item.id
                                        onSelection?(selectedId)
                                        scrollView.scrollTo(item)
                                    }
                                }
                        }
                    }
                }
            }
        }
        .padding(.all,4)
    }
}
extension TagList{
    func onItemSelected(_ action: ((Int) -> Void)?)-> TagList{
        var view = self
        view.onSelection = action
        return view
    }
}

struct TagList_Previews:PreviewProvider{
    @State static var item = [TagItem(title: "All",id: 0),TagItem(title: "World",id: 1), TagItem(title: "World 1",id: 2), TagItem(title: "World 2 as as as ",id: 3)]
    @State static var selectedItem = TagItem(title: "Hello")
    static var previews: some View {
        TagList(tagList: item).previewLayout(.sizeThatFits)
    }
}
