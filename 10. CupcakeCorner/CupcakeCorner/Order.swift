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
}
