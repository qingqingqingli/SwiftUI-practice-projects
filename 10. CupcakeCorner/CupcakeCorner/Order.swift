//
//  Order.swift
//

import Foundation

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    // type of cake
    @Published var type = 0
    
    // quantity of cakes that ordered
    @Published var quantity = 0
    
    // whether the user wants special requests
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                extraSprinkles = false
            }
        }
    }
    
    // whether to add extra frosting
    @Published var extraFrosting = false
    
    // whether to add extra sprinkles
    @Published var extraSprinkles = false
    
    // MARK: - for delivery details
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        !name.isEmpty && !streetAddress.isEmpty && !city.isEmpty && !zip.isEmpty
    }
    
    // MARK: - Price
    
    var cost: Double {
        // artificial cost
        var cost = Double(quantity) * 2
        cost += (Double(type) / 2)
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if extraSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
