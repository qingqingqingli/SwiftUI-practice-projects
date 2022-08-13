//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var showingDetailedExpense = false
    
    private var personalItems: [ExpenseItem] {
        expenses.items.filter { item in
            item.type == "Personal"
        }
    }
    
    private var businessItems: [ExpenseItem] {
        expenses.items.filter { item in
            item.type == "Business"
        }
    }
    
    private func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    @ViewBuilder
    func expenseSection(for items: [ExpenseItem], in header: String) -> some View {
        Section {
            ForEach(items) { item in
                ExpenseRowView(item: item)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showingDetailedExpense = true
                    }
                    .sheet(isPresented: $showingDetailedExpense) {
                        ExpenseDetailView(expense: item)
                    }
            }
            .onDelete(perform: removeItems)
        } header: {
            if items.count > 0 {
                Text(header)
                    .font(.headline)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                expenseSection(for: personalItems, in: "Personal")
                expenseSection(for: businessItems, in: "Business")
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
