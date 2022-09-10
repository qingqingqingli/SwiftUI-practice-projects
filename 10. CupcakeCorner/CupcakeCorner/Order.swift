//
//  Order.swift
//

import Foundation

class OrderObservable: ObservableObject {
    @Published var order: Order
    
    init(){
        order = Order(type: 0, quantity: 0, specialRequestEnabled: false, extraFrosting: false, extraSprinkles: false, name: "", streetAddress: "", city: "", zip: "")
    }
}

struct Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    // type of cake
    var type = 0
    
    // quantity of cakes that ordered
    var quantity = 0
    
    // whether the user wants special requests
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                extraSprinkles = false
            }
        }
    }
    
    // whether to add extra frosting
    var extraFrosting = false
    
    // whether to add extra sprinkles
    var extraSprinkles = false
    
    // MARK: - for delivery details
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        name.isNotEmptyString() &&
        streetAddress.isNotEmptyString() &&
        city.isNotEmptyString() &&
        zip.isNotEmptyString()
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

    // MARK: - To enable conforming to Codable
    
    enum CodingKeys: CodingKey {
        case type, quantity, specialRequestEnabled, extraFrosting, extraSprinkles, name, streetAddress, city, zip
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: CodingKeys.type)
        try container.encode(quantity, forKey: CodingKeys.quantity)
        
        try container.encode(specialRequestEnabled, forKey: CodingKeys.specialRequestEnabled)
        try container.encode(extraFrosting, forKey: CodingKeys.extraFrosting)
        try container.encode(extraSprinkles, forKey: CodingKeys.extraSprinkles)
        
        try container.encode(name, forKey: CodingKeys.name)
        try container.encode(streetAddress, forKey: CodingKeys.streetAddress)
        try container.encode(city, forKey: CodingKeys.city)
        try container.encode(zip, forKey: CodingKeys.zip)
    }
    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        type = try container.decode(Int.self, forKey: CodingKeys.type)
//        quantity = try container.decode(Int.self, forKey: CodingKeys.quantity)
//
//        specialRequestEnabled = try container.decode(Bool.self, forKey: CodingKeys.specialRequestEnabled)
//        extraFrosting = try container.decode(Bool.self, forKey: CodingKeys.extraFrosting)
//        extraSprinkles = try container.decode(Bool.self, forKey: CodingKeys.extraSprinkles)
//
//        name = try container.decode(String.self, forKey: CodingKeys.name)
//        streetAddress = try container.decode(String.self, forKey: CodingKeys.streetAddress)
//        city = try container.decode(String.self, forKey: CodingKeys.city)
//        zip = try container.decode(String.self, forKey: CodingKeys.zip)
//    }
//
//    // Add empty initializer to allow for the creation of empty order object
//    init() {}
}
