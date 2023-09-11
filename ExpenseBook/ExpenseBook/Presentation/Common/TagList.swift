//
//  TagList.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 20/10/22.
//

import SwiftUI

struct TagItem: Hashable {
    var title: String = ""
    var id: Int = 0
}

struct TagList: View {
    private var tagList: [TagItem]
    private var onSelection: ((TagItem) -> Void)?
    private var selectedTextColor = Color.white
    private var normalTextColor = Color.black
    private var selectedBackgroundColor = Color.blue.opacity(0.6)
    private var normalBackgroundColor = Color.gray.opacity(0.3)
    private var itemCornerRadius = 16.0
    private var scaleSelectedItem = true
    @State private var selectedId: Int?

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { scrollView in
                    HStack {
                        ForEach(tagList, id: \.self) { item in
                            Text(item.title)
                                .fontWeight(.medium)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .foregroundColor(selectedId == item.id ? selectedTextColor : normalTextColor)
                                .background(selectedId == item.id ? selectedBackgroundColor : normalBackgroundColor)
                                .cornerRadius(itemCornerRadius)
                                .clipped(antialiased: true)
                                .onTapGesture {
                                    withAnimation {
                                        if selectedId == item.id {
                                            return
                                        }
                                        selectedId = item.id
                                        onSelection?(item)
                                        scrollView.scrollTo(item)
                                    }
                                }
                        }
                    }.onAppear {
                        if let item = tagList.first(where: { $0.id == selectedId }) {
                            scrollView.scrollTo(item)
                        }
                    }
                }
            }
        }
        .padding(.all, 4)
    }
}

// initializer
extension TagList {
    init(list: [TagItem], selectedId: Int? = nil) {
        tagList = list
        if let item = selectedId ?? list.first?.id {
            _selectedId = State(initialValue: item)
        } else {
            _selectedId = State(initialValue: 0)
        }
    }
}

// methods
extension TagList {
    func onItemSelected(_ action: ((TagItem) -> Void)?) -> TagList {
        var view = self
        view.onSelection = action
        return view
    }

    func selectedTextColor(_ color: Color) -> TagList {
        var view = self
        view.selectedTextColor = color
        return view
    }

    func normalTextColor(_ color: Color) -> TagList {
        var view = self
        view.normalTextColor = color
        return view
    }

    func selectedBackgroundColor(_ color: Color) -> TagList {
        var view = self
        view.selectedBackgroundColor = color
        return view
    }

    func normalBackgroundColor(_ color: Color) -> TagList {
        var view = self
        view.normalBackgroundColor = color
        return view
    }

    func itemCornerRadius(_ radius: Double) -> TagList {
        var view = self
        view.itemCornerRadius = radius
        return view
    }

    func scaleSelectedItem(_ scaleSelectedItem: Bool) -> TagList {
        var view = self
        view.scaleSelectedItem = scaleSelectedItem
        return view
    }
}

struct TagList_Previews: PreviewProvider {
    @State static var item = [TagItem(title: "All", id: 0),
                              TagItem(title: "World", id: 1),
                              TagItem(title: "World 1", id: 2),
                              TagItem(title: "World 2", id: 3)]
    @State static var selectedItem = TagItem(title: "Hello")
    static var previews: some View {
        TagList(list: item, selectedId: 3).previewLayout(.sizeThatFits)
    }
}
