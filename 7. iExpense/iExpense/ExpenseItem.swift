//
//  SecondView.swift
//

import Foundation

struct ExpenseItem {
    let name: String
    let type: String
    let amount: Double
}

class Expenses : ObservableObject {
    @Published var items = [ExpenseItem]()
}
