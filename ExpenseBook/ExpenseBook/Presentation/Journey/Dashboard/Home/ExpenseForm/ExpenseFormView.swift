//
//  AddExpenseView.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 23/09/22.
//

import Foundation
import SwiftUI

enum Fields: Hashable {
    case title
    case amount
}

struct ExpenseFormView: View {
    init(entity: CDExpense? = nil) {
        cdExpense = entity
        _model = StateObject(wrappedValue: ExpenseFormViewModel(expenseEntity: entity))
    }

    var cdExpense: CDExpense?

    @FetchRequest(
        entity: CDCategory.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CDCategory.title, ascending: true)]
    )
    private var categories: FetchedResults<CDCategory>

    @Environment(\.managedObjectContext) private var managedContext
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var context

    @StateObject private var model: ExpenseFormViewModel = .init()
    @FocusState private var focusField: Fields?
    @State private var hasAppeared: Bool = false
    @State private var showAddCategoryScreen = false
    @State private var textAreaDescription = ""

    var body: some View {
        NavigationView {
            Form {
                Section("Primary") {
                    Text("Title")
                        .fontWeight(.medium)
                        .listRowSeparator(.hidden)
                    TextField("Enter title for expense", text: $model.title)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                        .focused($focusField, equals: .title)
                        .onSubmit {
                            focusField = .amount
                        }
                        .submitLabel(.next)
                    Text("Amount")
                        .fontWeight(.medium)
                        .listRowSeparator(.hidden)
                    VStack(alignment: .leading, spacing: 0.0) {
                        DecimalTextField(value: $model.amount.animation(), clearFieldOnInit: cdExpense == nil)
                            .placeholder("Enter expense amount")
                            .setMaxLength(10)
                            .setPrecisionLength(2)
                            .setPrefix(Locale.autoupdatingCurrent.currencySymbol ?? "")
                            .focused($focusField, equals: .amount)
                            .frame(height: 36)
                        if !model.hintText.isEmpty {
                            Text(model.hintText)
                                .font(.caption2)
                                .fontWeight(.regular)
                                .foregroundColor(.gray)
                                .padding(.leading, 10.0)
                                .padding(.top, 4.0)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .listRowSeparator(.hidden)
                }

                Section("Secondary") {
                    DatePicker(selection: $model.date,
                               in: ...Date().nextNYearDate(2),
                               displayedComponents: .date) {
                        Text("Date").fontWeight(.medium)
                    }
                    .padding(.bottom, 4.0)

                    HStack {
                        Text("Expense Type")
                            .fontWeight(.medium)
                        Spacer()
                        Picker("", selection: $model.expenseType) {
                            ForEach(ExpenseType.allCases, id: \.self) {
                                Text($0.description.capitalized)
                            }
                        }
                        .pickerStyle(.segmented)
                        .fixedSize()
                    }
                    .listRowSeparator(.hidden)
                    .padding(.bottom, 8.0)
                }

                Section("Optional") {
                    if !categories.isEmpty {
                        Picker("Select category", selection: $model.category) {
                            Text("None").tag(CDCategory?(nil))
                            ForEach(categories, id: \.objectID) {
                                Text($0.title ?? "").tag($0 as CDCategory?)
                            }
                        }
                        .listRowSeparator(.hidden)
                        NavigationLink {
                            CategoryFormView()
                        } label: {
                            Text("Add more categories")
                        }

                    } else {
                        NavigationLink {
                            CategoryFormView()
                        } label: {
                            Text("Add category")
                        }
                    }
                }
            }
            .navigationBarItems(
                leading: Button(action: self.onCancelTapped) { Text("Cancel") },
                trailing: Button(action: self.onSaveTapped) { Text("Save")
                    .disabled(!model.isValidEntry)
                }
            )
            .navigationBarTitle(model.expenseToEdit != nil ? "Edit Expense" : "Add Expense")
            .navigationBarTitleDisplayMode(.inline)
        }
        .interactiveDismissDisabled()
        .onAppear {
            UITableView.appearance().backgroundColor = .white
        }
        .onDisappear {
            UITableView.appearance().backgroundColor = nil
        }
    }

    private func onCancelTapped() {
        presentationMode.wrappedValue.dismiss()
    }

    private func onSaveTapped() {
        if model.isValidEntry {
            model.saveExpense()
            presentationMode.wrappedValue.dismiss()
        }
    }
}
