//
//  SecondView.swift
//

import Foundation

// Identifiable: means that this type can be identified uniquely
struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses : ObservableObject {
    @Published var items = [ExpenseItem]()
}
