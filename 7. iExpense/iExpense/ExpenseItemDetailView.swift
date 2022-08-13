//
//  ExpenseItemDetailView.swift
//

import SwiftUI

struct ExpenseItemDetailView: View {
    
    let expense: ExpenseItem
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                SectionView(sectionName: "Expense", text: expense.name)
                SectionView(sectionName: "Type", text: expense.type)
                SectionView(sectionName: "Amount", text: "\(expense.amount)")
            }
            .toolbar {
                Button("OK") {
                    dismiss()
                }
            }
            .navigationTitle("Expense detail")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}

struct SectionView: View {
    let sectionName: String
    let text: String
    
    var body: some View {
        Section {
            Text(text)
        } header: {
            Text(sectionName)
                .font(.headline)
                .bold()
        }
    }
}

struct ExpenseItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let item = ExpenseItem(name: "test", type: "Personal", amount: 10.0)
        ExpenseItemDetailView(expense: item)
    }
}
