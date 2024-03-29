//
//  AddView.swift
//

import SwiftUI

struct AddView: View {
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("0.0",
                          value: $amount,
                          format: .currency(code: Expenses.currencyCode)
                )
                .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expenses")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let expenseItem = ExpenseItem(
                        name: name,
                        type: type,
                        amount: amount
                    )
                    expenses.items.append(expenseItem)
                    dismiss()
                }
                .disabled(name.count == 0 || amount == 0)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
