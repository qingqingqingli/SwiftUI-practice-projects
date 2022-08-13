//
//  SecondView.swift
//
import Foundation

// Identifiable: means that this type can be identified uniquely
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses : ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            // create an encoder and use it directly to encode
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    static var currencyCode: String {
        if let code = Locale.current.currencyCode {
            return code
        }
        return "USD"
    }
    
    static var currencySymbol: String {
        if let symbol = Locale.current.currencySymbol {
            return symbol
        }
        return "$"
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
