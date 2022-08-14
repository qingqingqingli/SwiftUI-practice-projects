//
//  Model.swift
//

import Foundation

struct Mission: Codable, Identifiable {
    // a nested struct, as it's only relevant to the Mission struct
    // it can also add additional context
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let crew: [CrewRole]
    let description: String
    let launchDate: Date?
    
    // use computed variable to ensure that a consistent value is sent
    // wherever this info is requested
    // 💡 ownership
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date:.abbreviated, time: .omitted) ?? "N/A"
    }
}
