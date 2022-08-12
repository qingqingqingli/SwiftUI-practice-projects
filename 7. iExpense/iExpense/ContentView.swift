//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    // use @StateObject only when creating a class instance
    // in the other cases, use @ObservedObject
    @StateObject var expenses = Expenses()
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            List {
                // if expenses are identifiable, we don't need to set a id
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    let expense = ExpenseItem(name: "test", type: "test_type", amount: 9.9)
                    expenses.items.append(expense)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
